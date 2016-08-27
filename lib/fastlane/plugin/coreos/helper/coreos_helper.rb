module Fastlane
  module Helper
    class CoreosHelper
      # class methods that you define here become available in your action
      # as `Helper::CoreosHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the coreos plugin helper!")
      end
    end
  end
end
