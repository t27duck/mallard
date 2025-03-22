# frozen_string_literal: true

module EntryList
  ENTRIES_PER_PAGE = 10

  extend ActiveSupport::Concern

  included do
    before_action :set_section
  end

  private

  def set_section
    @section = controller_name.singularize
  end

  def build_scopes_and_render(scope)
    @entries = fetch_entries(scope)
    @total_pages = total_pages(scope)
    render "entries/index"
  end

  def fetch_entries(entries)
    entries = entries.full_search(params[:search]) if params[:search].present?
    entries = entries.limit(ENTRIES_PER_PAGE).offset(ENTRIES_PER_PAGE * params[:page].to_i) if @pagination
    entries.includes(:feed).order(:published_at).select(:id, :title, :feed_id)
  end

  def total_pages(entries)
    entries = entries.full_search(params[:search]) if params[:search].present?
    count = entries.count
    return 0 if count.zero?

    (count / ENTRIES_PER_PAGE.to_f).to_i + 1
  end
end
