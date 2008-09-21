
require 'test/unit'
require 'lib/xri'

class XRITest < Test::Unit::TestCase

  def test_string_representation
    assert_equal "=john.doe", xri("=john.doe").to_s
  end

  def test_valid_xri_should_not_fail
    assert_nothing_raised do
      xri("=foobar")
    end
  end

  def test_uri_form
    assert_equal "=john.doe", xri("xri://=john.doe").to_s
  end

  def test_empty_xri_should_fail
    assert_raise XRI::InvalidIdentifierException do
      xri("")
    end
  end

  def test_persistent_global_context_symbol
    assert !xri("=john.doe").persistent?
    assert  xri("=!1000.a1b2.93d2.8c73").persistent?
  end

  def test_xri_with_only_global_context_symbol_should_fail
    %W[! @ = +].each do |xri|
      assert_raise XRI::InvalidIdentifierException do
        xri(xri)
      end
    end
  end

  def test_xri_with_spaces_should_fail
    assert_raise XRI::InvalidIdentifierException do
      xri("=foo bar")
    end
  end

  def test_person_iname
    xri = xri("=john.doe")
    assert  xri.person?
    assert !xri.organization?
    assert !xri.general_public?
  end

  def test_organization_iname
    xri = xri("@acme.corp")
    assert !xri.person?
    assert  xri.organization?
    assert !xri.general_public?
  end

  def test_general_public_iname
    xri = xri("+address")
    assert !xri.person?
    assert !xri.organization?
    assert  xri.general_public?
  end

  def test_equality
    assert_equal xri("=john.doe"), xri("=john.doe")
    assert_not_equal xri("=john.doe"), xri("=jane.doe")
  end

protected

  def xri(str)
    XRI.new(str)
  end

end
