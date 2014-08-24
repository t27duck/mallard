require File.expand_path '../../../test_helper.rb', __FILE__

class EntriesControllerTest < MiniTest::Test

  def setup
    complete_setup
    log_user_in
    @entry = Entry.first
  end

  def test_if_entry_isnt_found_render_404
    get "/entries/0"
    assert_response 404
    assert !last_response.body.nil?
  end

  def test_fetching_entry_renders_and_marks_entry_read
    get "/entries/#{@entry.id}"
    assert_response 200
    @entry.reload
    assert @entry.read
  end

  def test_read_action_entry_is_marked_as_read
    @entry.update_attributes!(:read => false)
    put "/entries/#{@entry.id}", {:entry => {:read => true}}
    assert_response 200
    @entry.reload
    assert @entry.read
  end

  def test_iunread_action_entry_is_marked_as_read
    @entry.update_attributes!(:read => true)
    put "/entries/#{@entry.id}", {:entry => {:read => false}}
    assert_response 200
    @entry.reload
    assert !@entry.read
  end

  def test_star_action_entry_is_marked_as_starred
    @entry.update_attributes!(:starred => false)
    put "/entries/#{@entry.id}", {:entry => {:starred => true}}
    assert_response 200
    @entry.reload
    assert @entry.starred
  end

  def test_unstar_action_entry_is_marked_as_unstarred
    @entry.update_attributes!(:starred => false)
    put "/entries/#{@entry.id}", {:entry => {:starred => true}}
    assert_response 200
    @entry.reload
    assert @entry.starred
  end

end
