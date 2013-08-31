module Vagrant
  module Errors
    class FabricFailed < VagrantError
      error_key("fabric_failed")
    end

    class FabricAppNotFound < VagrantError
      error_key("fabric_app_not_found")
    end
  end
end
