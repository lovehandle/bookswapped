module Ebay
  class Offer < Shared::Offer

    include Muffins

    base_path "item"

    map :link, :to => "viewItemURL"
    map :location, :to => "location"
    map :country, :to => "country"
    map :postal_code, :to => "postalCode"

    within "sellingStatus" do |status|
      status.map :price, :to => "currentPrice", :type => Float
    end

    within "shippingInfo" do |shipping|
      shipping.map :ship_rate, :to => "shippingServiceCost", :type => Float
      shipping.map :handling_time, :to  => "handlingTime"
    end

    within "sellerInfo" do |seller|
      seller.map :total_merchant_feedback, :to => "feedbackScore", :type => Integer
      seller.map :merchant_feedback, :to => "positiveFeedbackPercent", :type => Float
      seller.map :merchant_name, :to => "sellerUserName"
    end

    within "condition" do |condition|
      condition.map :subcondition, :to => "conditionDisplayName"
    end

    def vendor
      "eBay.com"
    end

    class << self
      def all(query)
        ean = query[:ean]

        parameters = {
          'outputSelector' => 'SellerInfo',
          'productId.@type' => 'EAN'
        }.merge('productId' => ean)

        request  = Ebay::Gateway.find_items_by_product(parameters)
        response = request.get
        response.offers
      end
    end
  end
end
