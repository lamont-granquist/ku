require "thor"

module Ku
  class CLI < Thor
    desc "test", "test"
    def test
      require "pp"
      require "ku/mod"
      require "ku/mod_collection"
      pp Mod.from_uri("https://raw.githubusercontent.com/KSP-CKAN/CKAN-meta/master/AstronomersPack/AstronomersPack-Interstellar.V2.ckan")
    end
  end
end
