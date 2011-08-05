module Abebooks
  class Response < Shared::Response

    def code
      response.response_header.status
    end

    def offers
      Offer.parse(doc)
    end

    def doc
      @doc ||= Nokogiri::HTML(response.response)
    end
  end
end
