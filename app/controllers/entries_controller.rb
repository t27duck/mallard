# frozen_string_literal: true

class EntriesController < ApplicationController
  before_action :fetch_entry, only: %i[show update]

  def unread
    render json: { entries: fetch_entries("unread") }
  end

  def read
    render json: {
      entries: fetch_entries("read", search: params[:search], page: params[:page].to_i),
      total: read_total(search: params[:search])
    }
  end

  def starred
    render json: { entries: fetch_entries("starred") }
  end

  def show
    render json: @entry
  end

  def update
    @entry.update(entry_params)
    head :ok
  end

  private

  def entry_params
    params.require(:entry).permit(:read, :starred)
  end

  def fetch_entry
    @entry = Entry.find(params[:id])
  end

  def fetch_entries(scope, page: nil, search: nil)
    scope = "unread" unless %w[unread read starred].include?(scope)

    entries = Entry.public_send(scope).order(:published_at)
    entries = entries.search_title(search) if search.presence
    entries = entries.limit(20).offset(20 * page) if page
    entries.map(&:minimum_hash)
  end

  def read_total(search: nil)
    entries = Entry.read
    entries = entries.search_title(search) if search.presence
    entries.count
  end
end
