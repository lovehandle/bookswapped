module Shared
  class Response
    def initialize(response)
      @response = response
    end


    protected

    attr_reader :response

  end
end
