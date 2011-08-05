module Shared
  class Offer

    attr_accessor :merchant_name, :comments, :average_merchant_feedback, :link
    attr_writer :price, :ship_rate, :condition, :availability

    def availability
      'Ships in 1-2 Business Days'
    end

    def condition
      'Used'
    end

    def ship_rate
      @ship_rate ||= 3.99
    end

    def price
      @price ||= 0.0
    end

    def total_price
      (price + ship_rate).round(2)
    end
  end
end
