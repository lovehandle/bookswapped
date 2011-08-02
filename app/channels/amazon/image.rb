module Amazon
  class Image

    HOST = "ecx.images-amazon.com"
    COUNTRY_CODE = "01"
    IMG_FORMAT = "jpg"

    SIZES = {
      :small => "SCTZZZZZZZ",
      :medium => "SCMZZZZZZZ",
      :large => "SCLZZZZZZZ"
    }

    SCALE_TYPES = {
      :proportion => "AA",
      :square => "SS",
      :width => "SX",
      :height => "SY"
    }

    SHADOW_POSITIONS = [:left, :right, :custom]

    TEXT_FONTS = [:times, :arial, :arialbi, :verdanab, :advc128d]
    TEXT_ALIGNS = [:left, :center]


    attr_accessor :asin

    def initialize(asin, &block)
      @asin = asin

      yield self if block_given?
    end

    def add_shadow!(side)
      transforms << "PB" if side == :left
      transforms << "PC" if side == :right
      self
    end

    def scale!(opts)
      transforms << opts.inject({}) do |options, opt|
        options[SCALE_TYPES[opt.first]] = opt.last; options
      end.to_s

      self
    end

    def set_size!(size)
      transforms << SIZES[size]; self
    end

    def url
      "http://#{HOST}/images/P/#{asin}.#{COUNTRY_CODE}._#{transforms.join('_')}_.#{IMG_FORMAT}"
    end

    protected

    def transforms
      @transforms ||= []
    end
  end
end
