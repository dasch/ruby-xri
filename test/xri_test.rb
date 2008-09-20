
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

  def test_personal_iname
    xri = XRI.new("=john.doe")
    assert  xri.personal?
    assert !xri.organizational?
    assert !xri.conceptual?
  end

  def test_organizational_iname
    xri = XRI.new("@acme.corp")
    assert !xri.personal?
    assert  xri.organizational?
    assert !xri.conceptual?
  end

  def test_conceptual_iname
    xri = XRI.new("+address")
    assert !xri.personal?
    assert !xri.organizational?
    assert  xri.conceptual?
  end

  def test_equality
    assert_equal XRI.new("=john.doe"), XRI.new("=john.doe")
    assert_not_equal XRI.new("=john.doe"), XRI.new("=jane.doe")
  end

end
