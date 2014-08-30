require File.expand_path '../../../test_helper.rb', __FILE__

class ApplicationControllerTest < MiniTest::Test

  def setup
    complete_setup
    log_user_in
  end

  def test_unread_entries_has_expected_entry_count
    get "/"
    assert_response 200

    doc = Nokogiri::HTML(last_response.body)
    expected_unread_entries = EntryRepo.unread.count
    unread_entries = doc.css("#entry-list .panel").size

    assert_equal expected_unread_entries, unread_entries
  end

  def test_starred_entries_has_expected_entry_count
    get "/starred"
    assert_response 200

    doc = Nokogiri::HTML(last_response.body)
    expected_unread_entries = EntryRepo.starred.count
    unread_entries = doc.css("#entry-list .panel").size

    assert_equal expected_unread_entries, unread_entries
  end

end
