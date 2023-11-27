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

module Settings
  module ProjectCustomFieldSections
    class ShowComponent < ApplicationComponent
      include ApplicationHelper
      include OpPrimer::ComponentHelpers
      include OpTurbo::Streamable

      def initialize(project_custom_field_section:)
        super

        @project_custom_field_section = project_custom_field_section
        @project_custom_fields = project_custom_field_section.custom_fields.reorder(position_in_custom_field_section: :asc)
      end

      private

      def wrapper_uniq_by
        @project_custom_field_section.id
      end

      def drag_and_drop_target_config
        {
          'is-drag-and-drop-target': true,
          'target-container-accessor': '.Box > ul', # the accessor of the container that contains the drag and drop items
          'target-id': @project_custom_field_section.id, # the id of the target
          'target-allowed-drag-type': 'custom-field' # the type of dragged items which are allowed to be dropped in this target
        }
      end

      def draggable_item_config(project_custom_field)
        {
          'draggable-id': project_custom_field.id,
          'draggable-type': 'custom-field',
          'drop-url': drop_admin_settings_project_custom_field_path(project_custom_field)
        }
      end

      def move_actions(menu)
        unless @project_custom_field_section.first?
          move_action_item(menu, :highest, t("label_agenda_item_move_to_top"),
                           "move-to-top")
        end
        move_action_item(menu, :higher, t("label_agenda_item_move_up"), "chevron-up") unless @project_custom_field_section.first?
        unless @project_custom_field_section.last?
          move_action_item(menu, :lower, t("label_agenda_item_move_down"),
                           "chevron-down")
        end
        unless @project_custom_field_section.last?
          move_action_item(menu, :lowest, t("label_agenda_item_move_to_bottom"),
                           "move-to-bottom")
        end
      end

      def move_action_item(menu, move_to, label_text, icon)
        menu.with_item(label: label_text,
                       href: move_admin_settings_project_custom_field_section_path(@project_custom_field_section, move_to:),
                       form_arguments: {
                         method: :put, data: { 'turbo-stream': true }
                       }) do |item|
          item.with_leading_visual_icon(icon:)
        end
      end

      def disabled_delete_action_item(menu)
        menu.with_item(label: t("text_destroy"),
                       disabled: true) do |item|
          item.with_leading_visual_icon(icon: :trash)
        end
      end

      def edit_action_item(menu)
        menu.with_item(label: t("text_edit"),
                       tag: :button,
                       content_arguments: { 'data-show-dialog-id': "project-custom-field-section-dialog#{@project_custom_field_section.id}" },
                       value: "") do |item|
          item.with_leading_visual_icon(icon: :pencil)
        end
      end

      def delete_action_item(menu)
        menu.with_item(label: t("text_destroy"),
                       scheme: :danger,
                       href: admin_settings_project_custom_field_section_path(@project_custom_field_section),
                       form_arguments: {
                         method: :delete, data: { confirm: t("text_are_you_sure"), 'turbo-stream': true }
                       }) do |item|
          item.with_leading_visual_icon(icon: :trash)
        end
      end
    end
  end
end