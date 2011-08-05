module MultiSearch
  class Offer

    CHANNELS = [Amazon::Offer, Abebooks::Offer, Ebay::Offer, Half::Offer]

    class << self

      def all(query = {})
        offers = ([]).tap do |offers|
          EM.synchrony do

            CHANNELS.each do |channel|
              offers << channel.all(query)
            end

            EM.stop
          end
        end.flatten

        offers.sort_by(&:total_price)
      end

    end

  end
end
