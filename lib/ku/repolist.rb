require "open-uri"
require "ku/rest_base"

module Ku
  class Repolist
    attr_accessor :repos
    include RestBase

    def repos
      @repos ||= {}
    end

    def fields
      %w{repos}
    end

    def repo?(repo)
      repos.key?(repo)
    end

    def [](repo)
      repos[repo]
    end

    def []=(repo, meta)
      repos[repo] = meta
    end

    def from_uri(uri)
      r = JSON.parse(open(uri.to_s).read)
      rep_hash = Hash[ r["repositories"].collect { |v| [ v["name"].downcase.tr("-", "_").to_sym, { uri: v["uri"] } ] } ]
      repos.merge!(rep_hash)
    end

    # bit of ugly hardcoding for now (FIXME: make this a default config setting, and allow override in kerbfile)
    # FIXME: also need to throttle this to once-per-day or something
    def load_default
      from_uri("https://raw.githubusercontent.com/KSP-CKAN/CKAN-meta/master/repositories.json")
    end

    def self.load_default
      rl = new
      rl.load_default
      rl
    end
  end
end
