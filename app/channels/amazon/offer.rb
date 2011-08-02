module Amazon
  class Offer < Shared::Offer

    include Muffins

    CART_URI = "http://www.amazon.com/gp/aws/cart/add.html"
    CART_PARAMETERS = {
      'AssociateTag'     => Sucker::Config.associate_tag,
      'SubscriptionID'   => Sucker::Config.key,
      'Quantity.1'       => 1
    }

    base_path 'Offer'

    map :free_shipping, :to => 'IsEligibleForSuperSaverShipping', :type => Boolean

    within "OfferAttributes" do |attributes|
      attributes.map :comments, :to => "ConditionNote"
      attributes.map :condition, :to => "Condition"
      attributes.map :subcondition, :to => "SubCondition"
    end

    within "OfferListing" do |listing|
      listing.map :price, :to => "FormattedPrice", :within => "Price", :type => Float
      listing.map :availability, :to => "Availability"
      listing.map :remote_id, :to => "OfferListingId"
    end

    within  "Merchant" do |merchant|
      merchant.map :total_merchant_feedback, :to => "TotalFeedback", :type => Integer
      merchant.map :merchant_feedback, :to => "AverageFeedbackRating", :type => Float
    end

    def link
      [CART_URI, '?', add_to_cart_parameters.to_query].join
    end

    def average_merchant_feedback
      "#{merchant_feedback}/5.0"
    end

    def vendor
      "Amazon.com"
    end

    def ship_rate
      @ship_rate ||= free_shipping ? 0.0 : 3.99
    end

    class << self
      def all(query)
        ean = query[:ean]
 
        parameters = {
          :id_type => 'EAN',
          :response_group => 'OfferFull',
          :merchant_id => 'All',
          :condition => 'All',
          :delivery_method => 'Ship',
          :search_index => 'Books'
        }.merge(:item_id => ean)
 
        request  = Amazon::Gateway.item_lookup(parameters)
        response = request.get
        response.offers
      end
    end
 
    protected

    def add_to_cart_parameters
      {
        'OfferListingId.1' => remote_id
      }.merge(CART_PARAMETERS)
    end
  end
end
