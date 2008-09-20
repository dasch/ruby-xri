
require 'xri/invalid_identifier_exception'

class XRI

  def initialize(xri)
    raise InvalidIdentifierException, xri if xri =~ /\s/

    @xri = xri
  end

end
