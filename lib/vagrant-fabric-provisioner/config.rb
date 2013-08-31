module VagrantPlugins
  module Fabric
    class Config < Vagrant.plugin("2", :config)
      attr_accessor :uses_dynamic_port
      attr_accessor :args

      def initialize
        @uses_dynamic_port = UNSET_VALUE
        @args              = UNSET_VALUE
      end

      def finalize!
        @uses_dynamic_port = nil if @uses_dynamic_port == UNSET_VALUE
        @args              = nil if @args == UNSET_VALUE
      end 
    end
  end
end
