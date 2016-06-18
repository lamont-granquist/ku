require "thor"

module Ku
  class CLI < Thor
    desc "test", "test"
    def test
      puts "test"
    end
  end
end
