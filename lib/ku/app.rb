require "ku/config"
require "ku/mod_collection"
require "ku/kerbfile"
require "ku/repolist"

module Ku
  class App
    include Ku::Util::ExtractTgz
    attr_accessor :kerbfile

    attr_accessor :mod_collection

    attr_accessor :repolist

    def kerbfile
      @kerbfile ||= Kerbfile.read
    end

    def repolist
      # FIXME: for now we hardcode always loading the default repolist
      @repolist ||= Repolist.load_default
    end

    def mod_collection
      @mod_collection ||= ModCollection.new
    end

    def config
      Config.instance
    end

    def read_sources
      kerbfile.sources.each do |src|
        raise "bad source: #{src}" unless repolist.repo?(src)
        puts "downloading #{repolist[src][:uri]}..."
        mod_collection.from_uri(repolist[src][:uri])
      end
    end

    def init
      config.load
      read_sources
    end

    def search
      init
      puts mod_collection
    end
  end
end
