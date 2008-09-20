
require 'test/unit'
require 'lib/xri'

class XRITest < Test::Unit::TestCase

  def test_valid_xri_should_not_fail
    assert_nothing_raised do
      XRI.new("=foobar")
    end
  end

  def test_xri_with_spaces_should_fail
    assert_raise XRI::InvalidIdentifierException do
      XRI.new("=foo bar")
    end
  end

end
