# frozen_string_literal: true

require "uri"

class EntriesController < ApplicationController
  before_action :fetch_entry, only: [:update]

  def update
    @entry.update(entry_params)
  end

  private

  def entry_params
    params.expect(entry: [:read, :starred])
  end

  def fetch_entry
    @entry = Entry.find(params[:id])
  end
end
