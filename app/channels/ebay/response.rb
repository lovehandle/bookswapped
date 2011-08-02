module Ebay
  class Response < Shared::Response
    def success?
      response.code == 200
    end

    def code
      response.code
    end

    def offers
      @offers ||= Ebay::Offer.parse(xml)
    end

    def xml
      response.xml
    end
  end
end
