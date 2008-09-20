
require 'xri/invalid_identifier_exception'

class XRI

  def initialize(xri)
    raise InvalidIdentifierException, xri if xri =~ /\s/

    @xri = xri
  end

  def personal?
    @xri =~ /^=/
  end

  def organizational?
    @xri =~ /^@/
  end

  def conceptual?
    @xri =~ /^\+/
  end

  def to_s
    @xri
  end

end
