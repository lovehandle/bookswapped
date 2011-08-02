module Amazon
  class SimilarProduct

    include Muffins

    base_path 'SimilarProduct'

    map :asin, :to => 'ASIN'
    map :title, :to => 'Title'

    def image
      Image.new(asin)
    end
  end
end
