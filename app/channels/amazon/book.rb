module Amazon
  class Book < ::Book

    include Muffins

    base_path 'Item'

    map :asin, :to => 'ASIN'

    within 'ItemAttributes' do |attributes|
      attributes.map :isbn, :to => 'ISBN'
      attributes.map :ean, :to => 'EAN'
      attributes.map :title, :to => 'Title'
      attributes.map :authors, :to => 'Author', :collection => true
      attributes.map :translators, :to => 'Creator[Role=Translator]', :collection => true
      attributes.map :edition, :to => 'Edition'
      attributes.map :cover, :to => 'Binding'
      attributes.map :publisher, :to => 'Publisher'
      attributes.map :pages, :to => 'NumberOfPages', :type => Integer
      attributes.map :publication_date, :to => 'PublicationDate'
      attributes.map :release_date, :to => 'ReleaseDate'
    end

    map :description, :to => 'Content', :within => 'EditorialReview'

    map :similar_products, :to => 'SimilarProducts', :type => SimilarProduct

    class << self

      def all(parameters)
        request  = Amazon::Gateway.item_search(parameters)
        response = request.get
        response.books
      end

      def find(ean)
        parameters = {
          :id_type => "EAN",
          :response_group => "Medium",
          :search_index => 'Books',
          :item_id => ean
        }

        request  = Amazon::Gateway.item_lookup(parameters)
        response = request.get
        response.books.first
      end
    end
  end
end
