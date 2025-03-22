# frozen_string_literal: true

class ReadsController < ApplicationController
  include EntryList

  def show
    @pagination = true
    build_scopes_and_render(Entry.read)
  end
end
