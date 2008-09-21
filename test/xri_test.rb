
require 'test/unit'
require 'lib/xri'

class XRITest < Test::Unit::TestCase

  def test_string_representation
    assert_equal "=john.doe", XRI.new("=john.doe").to_s
  end

  def test_valid_xri_should_not_fail
    assert_nothing_raised do
      XRI.new("=foobar")
    end
  end

  def test_empty_xri_should_fail
    assert_raise XRI::InvalidIdentifierException do
      XRI.new("")
    end
  end

  def test_xri_with_only_global_context_symbol_should_fail
    %W[! @ = +].each do |xri|
      assert_raise XRI::InvalidIdentifierException do
        XRI.new(xri)
      end
    end
  end

  def test_xri_with_spaces_should_fail
    assert_raise XRI::InvalidIdentifierException do
      XRI.new("=foo bar")
    end
  end

  def test_person_iname
    xri = XRI.new("=john.doe")
    assert  xri.person?
    assert !xri.organization?
    assert !xri.general_public?
  end

  def test_organization_iname
    xri = XRI.new("@acme.corp")
    assert !xri.person?
    assert  xri.organization?
    assert !xri.general_public?
  end

  def test_general_public_iname
    xri = XRI.new("+address")
    assert !xri.person?
    assert !xri.organization?
    assert  xri.general_public?
  end

  def test_equality
    assert_equal XRI.new("=john.doe"), XRI.new("=john.doe")
    assert_not_equal XRI.new("=john.doe"), XRI.new("=jane.doe")
  end

end
