#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2024 the OpenProject GmbH
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

RSpec.describe 'Quarantined attachments',
               type: :rails_request do

  shared_let(:other_author) { create(:user) }
  shared_let(:admin) { create(:admin) }

  shared_let(:container) { create(:work_package) }
  shared_let(:own_quarantined_attachment) do
    create(:attachment, container:, status: :quarantined, author: admin, filename: 'my-own.txt')
  end
  shared_let(:quarantined_attachment) do
    create(:attachment, container:, status: :quarantined, author: other_author, filename: 'other-1.txt')
  end
  shared_let(:scanned_attachment) do
    create(:attachment, container:, status: :scanned, author: other_author, filename: 'scanned-1.txt')
  end

  before do
    login_as admin
    ActionController::Base.allow_forgery_protection = false
  end

  around do |example|
    state = ActionController::Base.allow_forgery_protection
    begin
      ActionController::Base.allow_forgery_protection = false
      example.run
    ensure
      ActionController::Base.allow_forgery_protection = state
    end
  end

  describe 'DELETE /admin/quarantined_attachments/:id' do
    it 'allows management other attachments' do
      delete admin_quarantined_attachment_path(quarantined_attachment)
      expect(response).to be_redirect

      expect { quarantined_attachment.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'disallows own attachments' do
      delete admin_quarantined_attachment_path(own_quarantined_attachment)
      expect(response).to be_redirect

      expect { own_quarantined_attachment.reload }.not_to raise_error
    end

    it 'fails to find if not quarantined' do
      delete admin_quarantined_attachment_path(scanned_attachment)
      expect(response).to have_http_status 404
    end
  end

  describe 'PATCH /admin/quarantined_attachments/:id/override' do
    it 'allows management other attachments' do
      patch override_admin_quarantined_attachment_path(quarantined_attachment)
      expect(response).to be_redirect

      quarantined_attachment.reload
      expect(quarantined_attachment).to be_status_scanned
    end

    it 'disallows own attachments' do
      patch override_admin_quarantined_attachment_path(own_quarantined_attachment)
      expect(response).to be_redirect

      own_quarantined_attachment.reload
      expect(own_quarantined_attachment).to be_status_quarantined
    end

    it 'fails to find if not quarantined' do
      patch override_admin_quarantined_attachment_path(scanned_attachment)
      expect(response).to have_http_status 404
    end
  end
end
