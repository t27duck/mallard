require File.expand_path '../test_helper.rb', __FILE__

class SetupTest < MiniTest::Unit::TestCase

  def test_it_works
    get "/"
    assert last_response.ok?
  end

  def test_this_also_works
    ConfigInfo.create!(:key => "foo", :value => "bar")
    assert_equal ConfigInfo.get(:foo), "bar"
  end
  
  def test_this_also_also_works
    assert_equal ConfigInfo.get(:foo), "bar"
  end
end
