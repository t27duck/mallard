# frozen_string_literal: true

class EntriesController < ApplicationController
  before_action :fetch_entry, only: %i[show update]

  def unread
    render json: fetch_entries("unread").to_json(only: %i[id title])
  end

  def read
    render json: fetch_entries("read").to_json(only: %i[id title])
  end

  def starred
    render json: fetch_entries("starred").to_json(only: %i[id title])
  end

  def show
    render json: { entry: @entry }
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

  def fetch_entries(scope)
    scope = "unread" unless %w[unread read starred].include?(scope)

    Entry.public_send(scope).order(:published_at)
  end
end
