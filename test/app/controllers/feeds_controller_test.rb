require File.expand_path '../../../test_helper.rb', __FILE__

class FeedsControllerTest < MiniTest::Test

  def setup
    complete_setup
    log_user_in
    @feed = Feed.first
  end

  def test_feed_index_renders
    get "/feeds"
    assert_response 200
  end

  def test_feed_new_renders
    get "/feeds/new"
    assert_response 200
  end

  def test_feed_create_creates_feed_and_redirects
    old_feed_count = Feed.count
    fake_feed_object = OpenStruct.new({
      :title => "A feed",
      :etag => "abcde"
    })
    Feed.any_instance.stubs(:feed_object).returns(fake_feed_object)
    post "/feeds", :feed => {:url => "http://yahoo.com"}
    assert_redirected "/feeds"
    assert_equal 1, Feed.count - old_feed_count
  end

  def test_feed_create_rerenders_if_validation_fails
    old_feed_count = Feed.count
    post "/feeds", :feed => {}
    assert_response 200
    assert_equal old_feed_count, Feed.count
  end

  def test_feed_edit_renders
    get "/feeds/#{@feed.id}/edit"
    assert_response 200
  end

  def test_feed_edit_throws_404_if_feed_is_not_found
    get "/feeds/0/edit"
    assert_response 404
  end

  def test_feed_update_updates_feed_and_redirects
    new_title = "New title"
    old_title = @feed.title
    put "/feeds/#{@feed.id}", :feed => {:title => new_title}
    assert_redirected "/feeds"
    @feed.reload
    assert_equal new_title, @feed.title
    assert old_title != @feed.title
  end

  def test_feed_rerenders_if_valiation_fails
    new_title = nil
    put "/feeds/#{@feed.id}", :feed => {:title => new_title}
    assert_response 200
    @feed.reload
    assert new_title != @feed.title
  end

  def test_feed_update_throws_404_if_feed_is_not_found
    put "/feeds/0"
    assert_response 404
  end

  def test_feed_destory_removes_feed
    original_count = Feed.count
    delete "/feeds/#{@feed.id}"
    assert_redirected "/feeds"
    assert_equal 1, original_count - Feed.count
  end

end
