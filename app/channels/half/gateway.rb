require 'agent_cooper/synchrony'

module Half
  class Gateway < Shared::Gateway

    define_gateway :find_half_products, {
      'CALLNAME' => 'FindHalfProducts'
    }

    def get
      @request = AgentCooper::Shopper.new
      @request << parameters

      Half::Response.new(@request.get)
    end

  end
end
