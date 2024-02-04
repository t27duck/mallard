# frozen_string_literal: true

class EntriesController < ApplicationController
  PER_PAGE = 10
  VALID_SCOPES = ["unread", "read", "starred"].freeze

  before_action :fetch_entry, only: [:update]

  def unread
    @entries = fetch_entries("unread")
    @entry_type = "Unread"
    render :index
  end

  def read
    @section = "read"
    @entry_type = "Read"
    @pagination_and_search = true
    @entries = fetch_entries("read", search: params[:search], page: params[:page].to_i)
    @total_pages = total_pages(search: params[:search])
    render :index
  end

  def starred
    @section = "starred"
    @entry_type = "Starred"
    @entries = fetch_entries("starred")
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

  def fetch_entries(scope, page: nil, search: nil)
    scope = "unread" unless VALID_SCOPES.include?(scope)

    entries = Entry.public_send(scope)
    entries = entries.search_entry(search) if search.present?
    entries = entries.limit(PER_PAGE).offset(PER_PAGE * page) if page
    entries.order(:published_at).select(:id, :title)
  end

  def total_pages(search: nil)
    entries = Entry.read
    entries = entries.search_entry(search) if search.presence
    (entries.count / PER_PAGE.to_f).to_i + 1
  end
end
