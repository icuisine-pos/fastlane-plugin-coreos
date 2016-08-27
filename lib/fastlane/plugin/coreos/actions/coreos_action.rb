module Fastlane
  module Actions
    class CoreosAction < Action
      def self.run(params)
        UI.message("The coreos plugin is working!")
      end

      def self.description
        "Deploys docker services to CoreOS hosts."
      end

      def self.authors
        ["Oliver Letterer"]
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "COREOS_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
