# frozen_string_literal: true

class RefreshFeedsJob < ApplicationJob
  queue_as :default

  def perform
    Feed.find_each(&:fetch)
  end
end
