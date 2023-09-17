# frozen_string_literal: true

namespace :entries do
  desc "Fetch new entries"
  task fetch: :environment do
    Feed.find_each(&:fetch)
  end

  desc "Remove old read entries"
  task clean: :environment do
    Feed.find_each(&:clean)
  end
end
