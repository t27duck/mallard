# frozen_string_literal: true

class EntriesController < ApplicationController
  PER_PAGE = 10

  before_action :fetch_entry, only: [:update]

  def unread
    @section = "unread"
    @pagination = params[:search].present?
    @entries = fetch_entries(Entry.unread)
    @total_pages = total_pages(Entry.unread)
    render :index
  end

  def read
    @section = "read"
    @pagination = true
    @entries = fetch_entries(Entry.read)
    @total_pages = total_pages(Entry.read)
    render :index
  end

  def starred
    @section = "starred"
    @pagination = params[:search].present?
    @total_pages = total_pages(Entry.starred)
    @entries = fetch_entries(Entry.starred)
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

  def fetch_entries(entries)
    entries = entries.full_search(params[:search]) if params[:search].present?
    entries = entries.limit(PER_PAGE).offset(PER_PAGE * params[:page].to_i) if @pagination
    entries.order(:published_at).select(:id, :title)
  end

  def total_pages(entries)
    entries = entries.full_search(params[:search]) if params[:search].present?
    (entries.count / PER_PAGE.to_f).to_i + 1
  end
end
