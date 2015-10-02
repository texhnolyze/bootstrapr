require 'optparse'
require 'ostruct'

module Bootstrap
  class ArgumentParser
    def parse(args)
      options = OpenStruct.new
      options.version = "0.0.1" 

      options.project_home = File.expand_path(File.dirname(__FILE__) + '/../')

      options.install_npm_deps = false
      options.npm_install_path = "#{options.project_home}/src/SRGPlayerFrontend/resources/assets"

      options.install_bower_deps = false
      options.bower_install_path = "#{options.project_home}/src/SRGPlayerFrontend/resources/assets"

      options.run_grunt = false
      options.grunt_env = :dev

      options.packages = ["git", "apache2", "php5", "php5-xdebug", "nodejs", "npm"]

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: ruby bootstrap.rb -p [PACKAGES] [OPTIONS] [PROJECT_HOME]"

        opts.separator ""
        opts.separator "OPTIONS: "
        opts.separator ""

        opts.on("-p", "--packages [PACKAGES]", "add packages(seperated by comma) to install, default list is [git, apache2, php5, php5-xdebug, nodejs, npm]") do |packages|
          options.packages = options.packages + packages.split(',')
        end

        opts.on("--npm [PATH]", "install npm dependencies in PATH from PATH/package.json") do |path|
          options.install_npm_deps = true
          options.npm_install_path = path if path
        end

          opts.on("--bower [PATH]", "install bower dependencies in PATH from PATH/bower.json") do |path|
            options.install_bower_deps = true
            options.bower_install_path = path if path
        end

        opts.on("--grunt [ENVIRONMENT]", [:dev, :prod], "run grunt after installing frontend dependencies") do |env|
            options.install_bower_deps = true
            options.run_grunt = true
            options.grunt_env = env.to_sym
        end

        
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end

      opt_parser.parse!(args)
      options.project_home = ARGV.first unless ARGV.empty?
            options
    end
  end
end
