require 'agent_cooper/synchrony'

module Ebay
  class Gateway < Shared::Gateway

    define_gateway :find_items_by_product, {
      'OPERATION-NAME' => 'findItemsByProduct'
    }

    def get
      @request = AgentCooper::Finder.new
      @request << parameters

      Ebay::Response.new(@request.get)
    end
  end
end
