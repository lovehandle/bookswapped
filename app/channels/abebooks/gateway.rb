require 'em-synchrony'
require 'em-synchrony/em-http'

module Abebooks
  class Gateway < Shared::Gateway

    BASE_URI = "http://abebooks.com/servlet/SearchResults?"

    define_gateway :item_lookup, {
      :sortby => 17
    }

    def get
      response = EM::HttpRequest.new(url).get(:redirects => 3)
      Response.new(response)
    end

    def url
      BASE_URI + parameters.to_query
    end
  end
end
