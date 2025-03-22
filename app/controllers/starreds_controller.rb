# frozen_string_literal: true

class StarredsController < ApplicationController
  include EntryList

  def show
    @pagination = params[:search].present?
    build_scopes_and_render(Entry.starred)
  end
end
