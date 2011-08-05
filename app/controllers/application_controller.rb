class ApplicationController < ActionController::Base

  before_filter :set_body_class
  
  protect_from_forgery

  private

  def set_body_class
    @body_class = "#{params[:controller].parameterize}"
  end

  def find_book(ean)
    @book = Book.find_by_ean(ean)

    unless @book
      EM.synchrony do
        @book = Amazon::Book.find(ean)
        @book.save
        EM.stop
      end
    end

    @book
  end
  
  def find_offers
    @offers = Rails.cache.read("#{@book.ean}_offers")

    unless @offers
      parameters = {
        :ean  => @book.ean,
        :isbn => @book.isbn,
        :asin => @book.asin
      }

      @offers = MultiSearch::Offer.all(parameters)

      Rails.cache.write("#{@book.ean}_offers", @offers, :expires_in => 1.hour)
    end

    @offers
  end
end
