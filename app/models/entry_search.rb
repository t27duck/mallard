# frozen_string_literal: true

# Implementation in Entry based off of
# https://mariochavez.io/desarrollo/2023/09/01/full-text-search-with-sqlite-and-rails/
class EntrySearch < ApplicationRecord
  self.primary_key = :entry_id
end
