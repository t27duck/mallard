# frozen_string_literal: true

class FeedsController < ApplicationController
  before_action :fetch_feed, only: [:fetch, :edit, :update, :destroy]
  before_action :set_section

  def index
    @feeds = Feed.order(:title)
  end

  def new
    @feed = Feed.new
  end

  def edit
  end

  def fetch
    @feed.fetch
    redirect_to feeds_path, notice: "New entries fetched"
  end

  def create
    @feed = Feed.new(feed_params)
    if @feed.set_info && @feed.save
      @feed.fetch
      redirect_to feeds_path, notice: "Feed created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @feed.update(feed_params)
      redirect_to feeds_path, notice: "Feed updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @feed.destroy
    redirect_to feeds_path, notice: "Feed deleted", status: :see_other
  end

  private

  def fetch_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:title, :url, :sanitize)
  end

  def set_section
    @section = "feeds"
  end
end
