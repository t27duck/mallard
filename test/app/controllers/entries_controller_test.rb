require File.expand_path '../../../test_helper.rb', __FILE__

class EntriesControllerTest < MiniTest::Test

  def setup
    complete_setup
    log_user_in
    @entry = Entry.first
  end

  def test_fetching_entry_renders_and_marks_entry_read
    get "/entries/#{@entry.id}"
    assert_response 200
    @entry.reload
    assert @entry.read
  end

  def test_read_action_entry_is_marked_as_read
    @entry.update_attributes!(:read => false)
    get "/entries/#{@entry.id}/read"
    assert_response 200
    @entry.reload
    assert @entry.read
  end

  def test_iunread_action_entry_is_marked_as_read
    @entry.update_attributes!(:read => true)
    get "/entries/#{@entry.id}/unread"
    assert_response 200
    @entry.reload
    assert !@entry.read
  end

  def test_star_action_entry_is_marked_as_starred
    @entry.update_attributes!(:starred => false)
    get "/entries/#{@entry.id}/star"
    assert_response 200
    @entry.reload
    assert @entry.starred
  end

  def test_unstar_action_entry_is_marked_as_unstarred
    @entry.update_attributes!(:starred => false)
    get "/entries/#{@entry.id}/star"
    assert_response 200
    @entry.reload
    assert @entry.starred
  end

end
