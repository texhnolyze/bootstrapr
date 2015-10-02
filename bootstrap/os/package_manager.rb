module Bootstrap
  class PackageManager

    def initialize(config, cmd_executor)
      @config = config
      @executor = cmd_executor
    end
                                         
    def install(*packages)
      packages.each do |package|
        @executor.exec "#{@config.install} #{package}"     
      end
    end                                   
                                         
    def uninstall(*packages)
      packages.each do |package|
        @executor.exec "#{@config.uninstall} #{package}"   
      end
    end                                   
                                         
    def search(package)
      @executor.exec "#{@config.search} #{package}"      
    end                                   
                                         
    def update
      @executor.exec @config.update                      
    end                                   
                                         
    def upgrade
      @executor.exec @config.upgrade                     
    end                                   

    def clean
      @executor.exec @config.clean
    end

  end
end
