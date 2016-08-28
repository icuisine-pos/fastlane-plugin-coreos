module Fastlane
  module Helper
    class CoreosSystemdTemplate
      attr_reader :params

      # class methods that you define here become available in your action
      # as `Helper::CoreosHelper.your_method`
      #
      def self.with_params(params)
        CoreosSystemdTemplate.new(params).render
      end

      def initialize(params)
        @params = params
      end

      def render
        file = Tempfile.new('service')
        file.write ERB.new(File.read(@params[:service_file])).result(binding)
        file.close
        file
      end
    end
  end
end
