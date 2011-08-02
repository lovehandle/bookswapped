require 'sucker/synchrony'

module Amazon
  class Gateway < Shared::Gateway

    define_gateway :item_lookup, {
      :operation       => 'ItemLookup'
    }

    define_gateway :item_search, {
      :operation       => 'ItemSearch',
      :response_group  => 'Large',
      :search_index    => 'Books',
      :sort            => 'relevancerank',
      :item_page       => 1
    }

    define_gateway :item_similarities, {
      :operation       => 'SimilarityLookup',
      :response_group  => 'Large',
      :search_index    => 'Books',
      :similarity_type => 'Random'
    }


    def get
      @request = Sucker.new

      @request << parameters

      Amazon::Response.new(@request.get)
    end

  end
end
