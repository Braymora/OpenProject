# frozen_string_literal: true

#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2023 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

require 'spec_helper'
require_module_spec_helper

RSpec.describe Storages::Storages::BaseContract, :storage_server_helpers, webmock: true do
  let(:current_user) { create(:admin) }
  let(:storage_host) { 'https://host1.example.com' }
  let(:storage) { build(:nextcloud_storage, host: storage_host) }
  let(:contract) { described_class.new(storage, current_user) }

  it 'checks the storage url only when changed' do
    capabilities_request = mock_server_capabilities_response(storage_host)
    host_request = mock_server_config_check_response(storage_host)
    contract.valid?
    expect(capabilities_request).to have_been_made.once
    expect(host_request).to have_been_made.once

    WebMock.reset_executed_requests!
    storage.save
    contract.valid?
    expect(capabilities_request).not_to have_been_made
    expect(host_request).not_to have_been_made
  end

  describe 'Nextcloud application credentials validation' do
    before do
      mock_server_capabilities_response(storage.host)
      mock_server_config_check_response(storage.host)
    end

    context 'with valid credentials' do
      let(:storage) { build(:nextcloud_storage, :as_automatically_managed) }

      it 'passes validation' do
        credentials_request = mock_nextcloud_application_credentials_validation(storage.host)
        contract = described_class.new(storage, current_user)

        expect(contract).to be_valid
        expect(credentials_request).to have_been_made.once
      end
    end

    context 'with invalid credentials' do
      let(:storage) { build(:nextcloud_storage, :as_automatically_managed) }

      it 'fails validation' do
        credentials_request = mock_nextcloud_application_credentials_validation(storage.host, response_code: 401)
        contract = described_class.new(storage, current_user)

        expect(contract).not_to be_valid
        expect(contract.errors.to_hash).to eq({ password: ["is not valid."] })

        expect(credentials_request).to have_been_made.once
      end
    end

    context 'with unknown error' do
      let(:storage) { build(:nextcloud_storage, :as_automatically_managed) }

      it 'fails validation' do
        credentials_request = mock_nextcloud_application_credentials_validation(storage.host, response_code: 500)
        contract = described_class.new(storage, current_user)

        expect(contract).not_to be_valid
        expect(contract.errors.to_hash)
          .to eq({ password: ["could not be validated. Please check your storage connection and try again."] })

        expect(credentials_request).to have_been_made.once
      end
    end

    context 'when the storage is not automatically managed' do
      let(:storage) { build(:nextcloud_storage, :as_not_automatically_managed) }

      it 'skips credentials validation' do
        credentials_request = mock_nextcloud_application_credentials_validation(storage.host)
        contract = described_class.new(storage, current_user)

        expect(contract).to be_valid
        expect(credentials_request).not_to have_been_made
      end
    end

    context 'when the storage host has a subpath' do
      let(:storage) { build(:nextcloud_storage, :as_automatically_managed, host: 'https://host1.example.com/api') }

      it 'passes validation' do
        credentials_request = mock_nextcloud_application_credentials_validation(storage.host)
        contract = described_class.new(storage, current_user)

        expect(contract).to be_valid
        expect(credentials_request).to have_been_made.once
      end
    end
  end
end
