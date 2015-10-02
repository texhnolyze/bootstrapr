require 'yaml'
require 'ostruct'

module Bootstrap
  class ConfigResolver

    def initialize(config_file)
      @config = YAML.load_file(config_file)
    end

    def get(key)
      key_path = key.split('.')
      config_value = @config
      key_path.each do |partial_key|
        config_value = config_value[partial_key]
      end
      config_value
    end

    def get_object(key)
      config_value = get(key)
      config_value = OpenStruct.new(config_value) if config_value.is_a? Hash
      config_value
    end

  end
end
