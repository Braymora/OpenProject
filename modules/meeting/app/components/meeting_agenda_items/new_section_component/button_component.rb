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

module MeetingAgendaItems
  class NewSectionComponent::ButtonComponent < Base::Component

    def initialize(meeting:, active_work_package: nil, **kwargs)
      @meeting = meeting
      @active_work_package = active_work_package
    end

    def call
      form_with(
        url: new_meeting_agenda_item_path(@meeting), 
        method: :get, 
        data: { "turbo-stream": true }
      ) do |form|
        box_collection do |collection|
          if @active_work_package.present?
            collection.with_box do
              form.hidden_field :work_package_id, value: @active_work_package.id
            end
          end
          collection.with_box do
            button_content_partial
          end
        end
      end
    end

    private

    def button_content_partial
      render(Primer::Beta::Button.new(
        my: 5,
        size: :medium,
        disabled: false,
        scheme: :primary,
        show_tooltip: true,
        type: :submit,
        "aria-label": "Add agenda item"
      )) do
        if @active_work_package.present?
          "Add work package to agenda"
        else
          "Add agenda item"
        end
      end
    end

  end
end
