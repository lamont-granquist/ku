require "singleton"
require "json"

module Ku
  class Config
    include Singleton

    attr_accessor :settings
    attr_accessor :defaults
    attr_accessor :fields

    def self.config(name, default: nil)
      instance.fields << name
      instance.defaults[name] = default
    end

    def fields
      @fields ||= []
    end

    def settings
      @settings ||= {}
    end

    def defaults
      @defaults ||= {}
    end

    config :sources, default: {
      default: "https://github.com/KSP-CKAN/CKAN-meta/archive/master.tar.gz"
    }

    def [](key)
      raise "bad config key" unless fields.include?(key)
      settings.key?(key) ? settings[key] : defaults[key]
    end

    def []=(key, value)
      raise "bad config key" unless fields.include?(key)
      settings[key] = value
    end

    def from_hash(h)
      settings.merge!(h)
    end

    def from_json(j)
      from_hash(JSON.parse(j, symbolize_names: true))
    end

    def from_file(file)
      from_json(IO.read(file))
    end

    def load(config_file = nil)
      default_config_file = File.expand_path(File.join(Dir.home, ".ku", "config.json"))
      config_file ||= default_config_file if File.exist?(default_config_file)
      unless config_file.nil?
        from_file(config_file)
      end
    end
  end
end
