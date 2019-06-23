# frozen_string_literal: true

class FeedsController < ApplicationController
  def list
    feeds = Feed.order(:title)
    render json: { feeds: feeds }
  end

  def fetch
    feed = Feed.find(params[:id])
    feed.fetch
    render json: { alert: { type: "notice", message: "New entries fetched" } }
  end

  def create
    feed = Feed.new(url: params[:url])
    if feed.set_info && feed.save
      feed.fetch
      render json: { alert: { type: "notice", message: "Feed saved" } }
    else
      render json: { alert: { type: "alert", message: "Unable to save feed" } }
    end
  end

  def destory
    feed = Feed.find(params[:id])
    feed.destroy
    render json: { alert: { type: "notice", message: "Feed deleted" } }
  end
end
