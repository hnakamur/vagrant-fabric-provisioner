module VagrantPlugins
  module Fabric
    class Provisioner < Vagrant.plugin("2", :provisioner)
      def provision
        ssh_info = machine.ssh_info
        user = ssh_info[:username]
        host = ssh_info[:host]
        port = ssh_info[:port]
        private_key = ssh_info[:private_key_path]
        system "#{config.fabric_path} -f #{config.fabfile_path} -i #{private_key} --user=#{user} --hosts=#{host} --port=#{port} #{config.tasks.join(' ')}"
      end
    end
  end
end
