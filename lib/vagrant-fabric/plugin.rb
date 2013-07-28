require "vagrant"

module VagrantPlugins
  module Fabric
    module Plugin < Vagrant.plugin("2")
      name "fabric"
      description <<-DESC
      Provides support for porvisioning your virtual machines with
      python fabric scripts.
      DESC

      config(:fabric, :provisioner) do
        require File.expand_path("../config", __FILE__)
        Config
      end

      provisioner(:fabric) do
        require File.expand_path("../provisioner", __FILE__)
        Provisioner
      end
    end
  end
end
