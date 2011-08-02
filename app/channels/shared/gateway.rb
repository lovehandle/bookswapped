module Shared
  class Gateway

    def initialize(parameters = {})
      @parameters = parameters
    end

    class << self

      protected
      
      def define_gateway(method, default_parameters)
        self.class.instance_eval do
          define_method("#{method}") do |parameters|
            query_parameters = default_parameters.merge(parameters)
            new(query_parameters)
          end
        end
      end
    end

    protected

    attr_reader :parameters

  end
end
