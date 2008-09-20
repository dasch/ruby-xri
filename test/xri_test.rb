
require 'test/unit'
require 'lib/xri'

class XRITest < Test::Unit::TestCase

  def test_xri_with_spaces_should_fail
    assert_raise XRI::InvalidIdentifierException do
      XRI.new("=foo bar")
    end
  end

end
