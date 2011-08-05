module Abebooks
  class Offer < Shared::Offer

    CART_URI = "http://www.abebooks.com/servlet/SearchResults?"

    include Muffins

    base_path 'table.result'

    map :price, :to => '.result-price .price', :type => Float
    map :ship_rate, :to => '.result-shippingPrice .price', :type => Float
    map :description, :to => '.result-description p:nth-child(1)'

    def condition
      @condition ||= description.include?('Book Condition: New') ? 'New' : 'Used'
    end

    def vendor
      'Abebooks.com'
    end

    class << self
      def all(params)
        parameters = {
          :isbn => params[:ean]
        }

        request  = Abebooks::Gateway.item_lookup(parameters)
        response = request.get

        # FUCKING DIRTY
        offers = response.offers
        offers.map {|o| o.link = CART_URI + "isbn=#{params[:ean]}"}

        offers
      end
    end
  end
end
