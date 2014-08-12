require File.expand_path '../../../test_helper.rb', __FILE__

class EntryTest < MiniTest::Test
  def test_entry_identifier_entry_id_takes_presidence
    entry = OpenStruct.new(:entry_id => "entry_id", :guid => "guid", :url => "url")
    assert_equal "entry_id", Entry.determine_identifier(entry)
  end
  
  def test_entry_identifier_guid_is_used_if_no_entry_id
    entry = OpenStruct.new(:guid => "guid", :url => "url")
    assert_equal "guid", Entry.determine_identifier(entry)
    
    entry = OpenStruct.new(:entry_id => nil, :guid => "guid", :url => "url")
    assert_equal "guid", Entry.determine_identifier(entry)
  end

  def test_entry_identifier_url_is_used_if_no_entry_id_or_guid
    entry = OpenStruct.new(:url => "url")
    assert_equal "url", Entry.determine_identifier(entry)
    
    entry = OpenStruct.new(:guid => nil, :url => "url")
    assert_equal "url", Entry.determine_identifier(entry)
  end

end
