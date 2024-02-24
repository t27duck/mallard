# frozen_string_literal: true

class EntriesController < ApplicationController
  PER_PAGE = 10
  VALID_SCOPES = ["unread", "read", "starred"].freeze

  before_action :fetch_entry, only: [:update]

  def unread
    @entries = fetch_entries("unread", search: params[:search], page: params[:page])
    @pagination = params[:search].present?
    @total_pages = total_pages(search: params[:search])
    @entry_type = "Unread"
    render :index
  end

  def read
    @section = "read"
    @entry_type = "Read"
    @pagination = params[:search].present?
    @entries = fetch_entries("read", search: params[:search], page: params[:page])
    @total_pages = total_pages(search: params[:search])
    render :index
  end

  def starred
    @section = "starred"
    @entry_type = "Starred"
    @pagination = params[:search].present?
    @total_pages = total_pages(search: params[:search])
    @entries = fetch_entries("starred", search: params[:search], page: params[:page])
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
    entries = entries.full_search(search) if search.present?
    entries = entries.limit(PER_PAGE).offset(PER_PAGE * page.to_i) if page
    entries.order(:published_at).select(:id, :title)
  end

  def total_pages(search: nil)
    entries = Entry.read
    entries = entries.full_search(search) if search.present?
    (entries.count / PER_PAGE.to_f).to_i + 1
  end
end
