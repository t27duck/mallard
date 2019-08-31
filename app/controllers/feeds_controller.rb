# frozen_string_literal: true

class FeedsController < ApplicationController
  before_action :fetch_feed, only: %i[fetch create update destroy]

  def list
    render json: feed_list
  end

  def fetch
    @feed.fetch
    render json: { feeds: feed_list, alert: { type: "notice", message: "New entries fetched" } }
  end

  def create
    feed = Feed.new(url: params[:url])
    if feed.set_info && feed.save
      feed.fetch
      render json: { alert: { type: "notice", message: "Feed created" } }
    else
      render json: { alert: { type: "alert", message: "Unable to save feed" } }
    end
  end

  def update
    @feed.update(feed_params)
    render json: { feeds: feed_list, alert: { type: "notice", message: "Feed updated" } }
  end

  def destroy
    @feed.destroy
    render json: { alert: { type: "notice", message: "Feed deleted" } }
  end

  private

  def fetch_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:sanitize)
  end

  def feed_list
    Feed.with_entry_count.order(:title)
  end
end
