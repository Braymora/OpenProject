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

require 'support/pages/page'
require_relative './board_page'

module Pages
  class BoardOverview < Page
    def visit!
      navigate_to_modules_menu_item("Boards")
    end

    def expect_global_menu_item_selected
      within '#main-menu' do
        expect(page).to have_selector('.selected', text: 'Boards')
      end
    end

    def expect_no_boards_listed
      within '#content-wrapper' do
        expect(page).to have_content I18n.t(:no_results_title_text)
      end
    end

    def expect_boards_listed(*boards)
      within '#content-wrapper' do
        boards.each do |board|
          expect(page).to have_selector("td.name", text: board.name)
        end
      end
    end

    def expect_to_be_on_page(number)
      expect(page).to have_selector('.op-pagination--item_current', text: number)
    end

    def to_page(number)
      within '.op-pagination--pages' do
        click_link number.to_s
      end
    end

    def expect_boards_not_listed(*boards)
      within '#content-wrapper' do
        boards.each do |board|
          expect(page).not_to have_selector("td.title", text: board.name)
        end
      end
    end
  end
end