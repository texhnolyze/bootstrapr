module Bootstrap

  require_relative 'bootstrap/config_resolver'
  require_relative 'bootstrap/os/package'
  require_relative 'bootstrap/os/package_manager'
  require_relative 'bootstrap/os/command_executor'

  NPM_PACKAGE_MANAGER = 'npm.package_manager'
  BOWER_PACKAGE_MANGER = 'bower.package_manager'
  COMPOSER_PACKAGE_MANGER = 'composer.package_manager'
  OS_PACKAGE_MANAGER = 'debian.package_manager'

  def setup
    local_path = File.expand_path(File.dirname(__FILE__))
    cmd_executor = Bootstrap::CommandExecutor.new
    os_setup(local_path, cmd_executor)
    npm_setup(local_path, cmd_executor)
    bower_setup(local_path, cmd_executor)
    compser_setup(local_path, cmd_executor)
  end

  def os_setup(path, cmd_executor)
    os_config = Bootstrap::ConfigResolver.new(path + '/bootstrap/config/os.yml')
    @package_manager = Bootstrap::PackageManager.new(os_config.get_object(OS_PACKAGE_MANAGER), cmd_executor)
  end

  def npm_setup(path, cmd_executor)
    npm_config = Bootstrap::ConfigResolver.new(path + '/bootstrap/config/npm.yml')
    @npm = Bootstrap::PackageManager.new(npm_config.get_object(NPM_PACKAGE_MANAGER), cmd_executor)
  end

  def bower_setup(path, cmd_executor)
    bower_config = Bootstrap::ConfigResolver.new(path + '/bootstrap/config/bower.yml')
    @bower = Bootstrap::PackageManager.new(bower_config.get_object(BOWER_PACKAGE_MANGER), cmd_executor)
  end

  def compser_setup(path, cmd_executor)
    composer_config = Bootstrap::ConfigResolver.new(path + '/bootstrap/config/composer.yml')
    @composer = Bootstrap::PackageManager.new(composer_config.get_object(COMPOSER_PACKAGE_MANGER), cmd_executor)
  end

  def run(&block)
    setup
    Bootstrap.class_eval(&block)
  end

  def npm(&block)
    @npm.instance_eval(&block)
  end

  def bower(&block)
    @bower.instance_eval(&block)
  end

  def composer(&block)
    @composer.instance_eval(&block)
  end

  def package_manager(&block)
    @package_manager.instance_eval(&block)
  end

  module_function :run, :setup, :npm_setup, :os_setup, :compser_setup, :bower_setup, :npm, :bower, :composer, :package_manager
end
