require_relative './spec_helper'

describe Bootstrap::ConfigResolver do

  config_file = '../config.yml'
  config = {'root' => { 'sub' => 'value', 'test' => {'sub_sub' => 'empty'}}}

  describe '#new' do
    it 'should take a YAML config_file argument and load it' do
      expect(YAML).to receive(:load_file).with(config_file)
      Bootstrap::ConfigResolver.new(config_file)
    end
  end

  describe '#get' do
    it 'should take a root key and return the corresponding config value' do
      expect(YAML).to receive(:load_file).with(config_file).and_return(config)
      expect(Bootstrap::ConfigResolver.new(config_file).get('root')).to eq(config['root'])
    end

    it 'should take a key path seperated by . and return config value' do
      expect(YAML).to receive(:load_file).with(config_file).and_return(config)
      expect(Bootstrap::ConfigResolver.new(config_file).get('root.sub')).to eq(config['root']['sub'])
    end
  end

  describe '#get_object' do
    it 'should take a root key and return the corresponding config object' do
      expect(YAML).to receive(:load_file).with(config_file).and_return(config)
      config_object = Bootstrap::ConfigResolver.new(config_file).get_object('root')
      expect(config_object.sub).to eq(config['root']['sub'])
      expect(config_object.test).to eq(config['root']['test'])
    end

    it 'should take a key path seperated by . and return the corresponding config object' do
      expect(YAML).to receive(:load_file).with(config_file).and_return(config)
      config_object = Bootstrap::ConfigResolver.new(config_file).get_object('root.test')
      expect(config_object.sub_sub).to eq('empty')
    end
  end

  it 'should return the value if on bottom config leaf' do
    expect(YAML).to receive(:load_file).with(config_file).and_return(config)
    config_value = Bootstrap::ConfigResolver.new(config_file).get_object('root.sub')
    expect(config_value).to eq('value')
  end

end 
