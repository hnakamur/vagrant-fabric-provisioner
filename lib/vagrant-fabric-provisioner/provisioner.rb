require_relative 'errors'

module VagrantPlugins
  module Fabric
    class Provisioner < Vagrant.plugin("2", :provisioner)
      def provision
        ssh = @machine.ssh_info
        command = ['fab', '-i', ssh[:private_key_path], '-u', ssh[:username]]
        if config.uses_dynamic_port
          command << '--port' << ssh[:port].to_s
        end
        if config.args
          config.args.each do |arg|
            command << arg
          end
        end
        @machine.ui.info(command.join(' '), :color => :green)

        # Write stdout and stderr data, since it's the regular Fabric output
        command << {
          :notify => [:stdout, :stderr]
        }

        begin
          result = Vagrant::Util::Subprocess.execute(*command) do |type, data|
            if type == :stdout || type == :stderr
              @machine.env.ui.info(data, :new_line => false, :prefix => false)
            end
          end

          raise Vagrant::Errors::FabricFailed if result.exit_code != 0
        rescue Vagrant::Util::Subprocess::LaunchError
          raise Vagrant::Errors::FabricAppNotFound
        end
      end
    end
  end
end
