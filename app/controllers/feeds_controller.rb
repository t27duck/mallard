# frozen_string_literal: true

class FeedsController < ApplicationController
  before_action :fetch_feed, only: [:fetch, :edit, :update, :destroy]
  before_action :set_section
  before_action :sticky_navbar

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
    redirect_to feeds_path, notice: translate("flash.entries_fetched")
  end

  def create
    @feed = Feed.new(feed_params)
    if @feed.set_info && @feed.save
      @feed.fetch
      redirect_to feeds_path, notice: translate("flash.feed_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @feed.update(feed_params)
      redirect_to feeds_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @feed.destroy
    redirect_to feeds_path, notice: translate("flash.feed_removed"), status: :see_other
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
