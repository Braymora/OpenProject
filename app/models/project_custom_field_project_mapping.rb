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

class ProjectCustomFieldProjectMapping < ApplicationRecord
  belongs_to :project
  belongs_to :project_custom_field, class_name: 'ProjectCustomField', foreign_key: 'custom_field_id',
                                    inverse_of: :project_custom_field_project_mappings

  # # Additionally to the database-level unique constraint, the application-level validation ensures that a
  # # custom_field is associated with only one section
  # validate :project_custom_field_uniqueness

  # private

  # def project_custom_field_uniqueness
  #   if ProjectCustomFieldSectionMapping.where(custom_field_id:).where.not(id:).exists?
  #     errors.add(:project_custom_field, "is already associated with another section")
  #   end
  # end
end