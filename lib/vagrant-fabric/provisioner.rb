module VagrantPlugins
  module Fabric
    class Provisioner < Vagrant.plugin("2", :provisioner)
      def provision
        ssh_info = @machine.ssh_info
        user = ssh_info[:username]
        host = ssh_info[:host]
        port = ssh_info[:port]
        private_key = ssh_info[:private_key_path]
        if config.remote == false
          system "#{config.fabric_path} -f #{config.fabfile_path} " +
                "-i #{private_key} --user=#{user} --hosts=#{host} " +
                "--port=#{port} #{config.tasks.join(' ')}"
        else
          if config.install
            @machine.communicate.sudo("pip install fabric")
            @machine.env.ui.info "Finished to install fabric library your VM."
          end
          @machine.communicate.execute("#{config.fabric_path} -f #{config.fabfile_path} " +
              "--user=#{user} --hosts=127.0.0.1 --password=#{config.remote_password} " +
              "#{config.tasks.join(' ')}")
          @machine.env.ui.info"Finished to execute tasks of fabric."
        end
      end
    end
  end
end
