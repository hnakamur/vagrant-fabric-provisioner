module VagrantPlugins
  module Fabric
    class Config < Vagrant.plugin("2", :config)
      attr_accessor :fabfile_path
      attr_accessor :fabric_path
      attr_accessor :python_path
      attr_accessor :tasks
      attr_accessor :remote
      attr_accessor :remote_install
      attr_accessor :remote_password
      attr_accessor :remote_current_dir

      def initialize
        @fabfile_path = UNSET_VALUE
        @fabric_path = UNSET_VALUE
        @python_path = UNSET_VALUE
        @tasks = UNSET_VALUE
        @remote = UNSET_VALUE
        @remote_install = UNSET_VALUE
        @remote_password = UNSET_VALUE
        @remote_current_dir = UNSET_VALUE
      end

      def finalize!
        @fabfile_path = "fabfile.py" if @fabfile_path == UNSET_VALUE
        @fabric_path = "fab" if @fabric_path == UNSET_VALUE
        @python_path = "python" if @python_path == UNSET_VALUE
        @tasks = [] if @tasks == UNSET_VALUE
        @remote = false if @remote == UNSET_VALUE
        @remote_install = false if @remote_install == UNSET_VALUE
        @remote_password = "vagrant" if @remote_password == UNSET_VALUE
        @remote_current_dir = "." if @remote_current_dir == UNSET_VALUE
      end

      def execute(command)
        output = ''
        begin
          IO.popen(command, "w+") do |f|
            f.close_write
            output = f.read
          end
          output
        rescue Errno::ENOENT
          false
        end
      end

      def validate(env)
        if not @remote == true
          errors = _detected_errors

          errors << "fabfile does not exist." if not File.exist?(fabfile_path)

          install_fabric if @remote == true and @install == true

          command = "#{fabric_path} -V"
          output = execute(command)
          errors << "fabric command does not exist." if not output

          command = "#{fabric_path} -f #{fabfile_path} -l"
          output = execute(command)
          errors << "#{fabfile_path} could not recognize by fabric." if not $?.success?

          for task in tasks
            task = task.split(':').first
            command = "#{fabric_path} -f #{fabfile_path} -d #{task}"
            output = execute(command)
            errors << "#{task} task does not exist." if not $?.success?
          end

          {"fabric provisioner" => errors}
        end
      end

      def install_fabric()
      end
    end
  end
end
