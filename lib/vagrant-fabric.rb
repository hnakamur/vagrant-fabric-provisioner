require "pathname"

require "vagrant-fabric/plugin"

module VagrantPlugins
  module Fabric
    lib_path = Pathname.new(File.expand_path("../vagrant-fabric", __FILE__))

    # This returns the path to the source of this plugin.
    #
    # @return [Pathname]
    def self.source_root
      @source_root ||= Pathname.new(File.expand_path("../../", __FILE__))
    end
  end
end
