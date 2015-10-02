#!/bin/ruby

require_relative './bootstrap.rb'

Bootstrap.run do
  npm do
    install "bower", "token", "test"
    clean
  end

  bower do 
    install
    uninstall "test"
  end

  composer do
    update
  end

  package_manager do
    install "ruby", "php5", "apache2"
  end
end
