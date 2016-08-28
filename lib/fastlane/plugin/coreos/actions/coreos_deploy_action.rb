module Fastlane
  module Actions
    class CoreosDeployAction < Action
      def self.run(params)
        raise "Service file #{params[:service_file]} does not exist" unless File.exist?(params[:service_file])

        host = params[:host]
        image = params[:image]
        service_name = params[:service_file].split("/").last.gsub(".erb", "")
        file = Helper::CoreosSystemdTemplate.with_params(params)

        sh "scp #{file.path} #{host}:#{service_name}"

        Net::SSH.start(host, ENV['USER']) do |ssh|
          UI.success("ssh #{ENV['USER']}@#{host}")

          user = params[:docker_hub_user]
          password = params[:docker_hub_password]

          # login
          if user and password
            UI.message "Performing docker login for #{user}"
            ssh.exec! "docker login -u #{user} -p #{password}"
            ssh.loop
            UI.success("You are now logged in as #{user}")
          end
        end

        login = "#{ENV['USER']}@#{host}"

        ssh = Proc.new { |command|
          sh %{ssh #{login} "#{command}"}
        }

        # pull image
        ssh.call "docker pull #{image}"

        existed = ssh.call("test -e /etc/systemd/system/#{service_name} && echo 1 || echo 0").to_i
        ssh.call "sudo mv #{service_name} /etc/systemd/system/"

        unless existed
          # start the service
          ssh.call "sudo systemctl enable /etc/systemd/system/#{service_name}"
          ssh.call "sudo systemctl start #{service_name}"
        else
          # restart service
          ssh.call "sudo systemctl daemon-reload"
          ssh.call "sudo systemctl restart #{service_name}"
        end
      end

      def self.description
        "Deploy docker services to CoreOS hosts"
      end

      def self.authors
        ["Oliver Letterer"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :docker_hub_user,
                                  env_name: "COREOS_DOCKER_HUB_USER",
                               description: "User for Docker Hub login",
                                  optional: true,
                                      type: String
                                      ),
          FastlaneCore::ConfigItem.new(key: :docker_hub_password,
                                  env_name: "COREOS_DOCKER_HUB_PASSWORD",
                               description: "Password for Docker Hub login",
                                  optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :image,
                                  env_name: "COREOS_DOCKER_IMAGE",
                               description: "Name of the docker image to deploy",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :host,
                                  env_name: "COREOS_HOST",
                               description: "Domain of the host to deploy to",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :service_file,
                                  env_name: "COREOS_SERVICE_FILE",
                               description: "Systemd service file to deploy",
                                  optional: false,
                                      type: String),
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
