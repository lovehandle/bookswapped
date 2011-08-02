module Half
  class Offer < Shared::Offer

    include Muffins

    base_path "Item"

    map :link, :to =>  "ViewItemURLForNaturalSearch"
    map :location, :to => "Location"
    map :country, :to => "Country"
    map :price, :to => "CurrentPrice", :type => Float
    map :subcondition, :to => "HalfItemCondition"
    map :comments, :to => "SellerComments"

    within "Seller" do |seller|
      seller.map :total_merchant_feedback, :to => "FeedbackScore", :type => Integer
      seller.map :merchant_feedback, :to => "PositiveFeedbackPercent", :type => Float
    end

    within "Storefront" do |store|
      store.map :merchant_name, :to => "StoreName"
    end

    def condition
      @condition ||= subcondition.include?("Brand") ? "New" : "Used"
    end

    def availability
      "Media Mail from #{location}"
    end

    def ship_rate
      @ship_rate ||= 3.49
    end

    def vendor
      "Half.com"
    end

    class << self
      def all(query)
        ean = query[:ean]

        parameters = {
          'ProductID.type' => 'EAN',
          'IncludeSelector' => 'Items'
        }.merge('ProductID.Value' => ean)

        request  = Half::Gateway.find_half_products(parameters)
        response = request.get
        response.offers
      end
    end
  end
end
