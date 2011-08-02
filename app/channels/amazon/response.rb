module Amazon
  class Response < Shared::Response

    def success?
      response.code == 200
    end
    
    def code
      response.code
    end

    def total_results
      @total_results ||= xml.at_css("TotalResults").try(:content).to_i
    end

    def books
      @books ||=  (Amazon::Book.parse(xml)).select do |book|
        book if book.ean.present?
      end.flatten
    end

    #TODO: Fix me. (Muffins in particular)
    def book
      @book = Amazon::Book.parse(xml, :single => true)
    end

    def offers
      @offers ||= Amazon::Offer.parse(xml)
    end

    def xml
      response.xml
    end
  end
end
