class Book < ActiveRecord::Base
  validates_presence_of :isbn, :ean, :asin
  validates_uniqueness_of :ean

  serialize :authors

  def to_param
    "#{title.parameterize}"
  end

  def image
    Amazon::Image.new(asin)
  end
end
