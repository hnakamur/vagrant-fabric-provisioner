module VagrantPlugins
  module Fabric
    class Config < Vagrant.plugin("2", :config)
      attr_accessor :fabfile_path
      attr_accessor :fabric_path
      attr_accessor :python_path
      attr_accessor :tasks

      def initialize
        @fabfile_path = UNSET_VALUE
        @fabric_path  = UNSET_VALUE
        @python_path  = UNSET_VALUE
        @tasks        = UNSET_VALUE
      end

      def finalize!
        @fabfile_path = "fabfile.py" if @fabfile_path == UNSET_VALUE
        @fabric_path = "fab" if @fabric_path == UNSET_VALUE
        @python_path = "python" if @python_path == UNSET_VALUE
        @tasks = [] if @tasks == UNSET_VALUE
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
        errors = _detected_errors

        errors << "fabfile does not exist." if not File.exist?(fabfile_path)

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

        { "fabric provisioner" => errors }
      end
    end
  end
end
