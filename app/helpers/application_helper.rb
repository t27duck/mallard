# frozen_string_literal: true

module ApplicationHelper
  def nav_entry_class(target)
    @section == target ? "nav-entry-active" : "nav-entry"
  end

  def pagination
    tag.nav class: "relative z-0 inline-flex shadow-sm" do
      prev_link + number_of_pages + next_link
    end
  end

  def prev_link
    page = params[:page].to_i.zero? ? params[:page].to_i : (params[:page].to_i - 1)
    link_to read_entries_path(page: page, search: params[:search]), class: "primary-color relative inline-flex items-center px-4 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" do
      "&laquo;".html_safe
    end
  end

  def number_of_pages
    tag.span class: "relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50" do
      "#{params[:page].to_i + 1} / #{@total_pages}"
    end
  end

  def next_link
    page = params[:page].to_i + 1 >= @total_pages ? params[:page].to_i : (params[:page].to_i + 1)
    link_to read_entries_path(page: page, search: params[:search]), class: "primary-color relative inline-flex items-center px-4 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" do
      "&raquo;".html_safe
    end
  end
end
