# frozen_string_literal: true

class EntriesController < ApplicationController
  PER_PAGE = 10

  before_action :fetch_entry, only: [:update]

  def unread
    @section = "unread"
    @entries = fetch_entries(Entry.unread, page: params[:page])
    @pagination = params[:search].present?
    @total_pages = total_pages(Entry.unread)
    @entry_type = "Unread"
    render :index
  end

  def read
    @section = "read"
    @entry_type = "Read"
    @pagination = true
    @entries = fetch_entries(Entry.read, page: params[:page] || 0)
    @total_pages = total_pages(Entry.read)
    render :index
  end

  def starred
    @section = "starred"
    @entry_type = "Starred"
    @pagination = params[:search].present?
    @total_pages = total_pages(Entry.starred)
    @entries = fetch_entries(Entry.starred, page: params[:page])
    render :index
  end

  def update
    @entry.update(entry_params)
  end

  private

  def entry_params
    params.require(:entry).permit(:read, :starred)
  end

  def fetch_entry
    @entry = Entry.find(params[:id])
  end

  def fetch_entries(entries, page: nil)
    entries = entries.full_search(params[:search]) if params[:search].present?
    entries = entries.limit(PER_PAGE).offset(PER_PAGE * page.to_i) if page
    entries.order(:published_at).select(:id, :title)
  end

  def total_pages(entries)
    entries = entries.full_search(params[:search]) if params[:search].present?
    (entries.count / PER_PAGE.to_f).to_i + 1
  end
end
