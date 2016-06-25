require "thor"
require "ku/app"

module Ku
  class CLI < Thor
    desc "search [STR] <options>", "search mods"
    option :author, type: :string
    option :name, type: :string
    option :identifier, type: :string
    option :abstract, type: :string
    def search(string=nil)
      Ku::App.new.search(string, name: options[:name], author: options[:author], identifier: options[:identifier], abstract: options[:abstract])
    end

    desc "test", "test"
    def test
      require "pp"
      require "ku/mod"
      require "ku/mod_collection"
      pp ModCollection.from_uri("https://github.com/KSP-CKAN/CKAN-meta/archive/master.tar.gz")
    end
  end
end
