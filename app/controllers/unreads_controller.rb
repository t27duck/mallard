# frozen_string_literal: true

class UnreadsController < ApplicationController
  include EntryList

  def show
    @pagination = params[:search].present?
    build_scopes_and_render(Entry.unread)
  end
end
