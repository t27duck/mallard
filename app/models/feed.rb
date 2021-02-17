# frozen_string_literal: true

class Feed < ApplicationRecord
  ADDITIONAL_UNREAD_ENTRIES_TO_KEEP = 5
  has_many :entries, dependent: :delete_all

  validates :title, :url, presence: true

  def set_info
    if url.blank?
      errors.add(:url, :blank)
      return false
    end

    unless feed_object
      errors.add(:base, "Unable to parse feed")
      return false
    end

    unless feed_object.respond_to?(:title)
      errors.add(:title, :blank)
      return false
    end

    self.title = feed_object.title
    true
  rescue StandardError
    false
  end

  def fetch
    return false if new_record?
    return false unless feed_object

    incoming_entries = feed_object.entries
    incoming_entries.each do |entry|
      Entry.create_from_feedjira(id, entry)
    end

    new_count = incoming_entries.size > entry_count_in_fetch ? incoming_entries.size : entry_count_in_fetch
    update(last_checked: Time.now.utc, entry_count_in_fetch: new_count)

    true
  end

  def clean
    return if entry_count_in_fetch.zero?

    entries.unstarred.read.where.not(
      id: Entry.where(feed_id: id).unstarred.read.order(published_at: :desc)
        .limit(entry_count_in_fetch + ADDITIONAL_UNREAD_ENTRIES_TO_KEEP)
    ).delete_all
  end

  # TODO: Maybe counter cache one day
  delegate :count, to: :entries, prefix: true

  private

  def feed_object
    @feed_object ||= begin
      body = feed_net_request

      Feedjira.parse(body) if body.present? || Rails.env.test?
    rescue StandardError
      nil
    end
  end

  def feed_net_request
    response = Faraday.new(url: url, request: { timeout: 5 }) do |conn|
      conn.use FaradayMiddleware::FollowRedirects
      conn.adapter(*Faraday.default_adapter)
    end.get
    return nil unless response.status == 200

    response.body
  rescue StandardError
    nil
  end
end
