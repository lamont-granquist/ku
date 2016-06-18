require "thor"
require "ku/app"

module Ku
  class CLI < Thor
    desc "search", "search"
    def search
      Ku::App.new.search
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
