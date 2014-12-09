# Add our custom translations to the load path
I18n.load_path << File.expand_path("../../../locales/en.yml", __FILE__)

module VagrantPlugins
  module Fabric
    class Plugin < Vagrant.plugin("2")
      name "Fabric Provisioner"
      description <<-DESC
      Provides support for provisioning your virtual machines with
      the Fabric fabfile.
      Check https://github.com/hnakamur/vagrant-fabric-provisioner 
      for further updates, or to make contributions.
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
