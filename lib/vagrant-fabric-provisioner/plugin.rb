module VagrantPlugins
  module Fabric
    class Plugin < Vagrant.plugin("2")
      name "Fabric Provisioner"
      description <<-DESC
      Provides support for provisioning your virtual machines with
      the Fabric fabfile.
      DESC

      config(:fabric, :provisioner) do
        require_relative 'config'
        Config
      end

      provisioner(:fabric) do
        require_relative 'provisioner'
        Provisioner
      end
    end
  end
end
