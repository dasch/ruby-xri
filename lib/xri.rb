
require 'xri/invalid_identifier_exception'

class XRI

  def initialize(xri)
    if xri.empty? or %w[! @ = +].include? xri or xri =~ /\s/
      raise InvalidIdentifierException, xri 
    end

    @xri = xri
  end

  def person?
    @xri =~ /^=/
  end

  def organization?
    @xri =~ /^@/
  end

  def general_public?
    @xri =~ /^\+/
  end

  def persistent?
    @xri =~ /^.!/
  end

  def == other
    @xri == other.to_s
  end

  def to_s
    @xri
  end

end
