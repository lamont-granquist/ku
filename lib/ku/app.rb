require "open-uri"
require "ku/config"
require "ku/mod_collection"
require "ku/kerbfile"
require "ku/util/extract_tgz"
require "json"

module Ku
  class App
    include Ku::Util::ExtractTgz
    attr_accessor :kerbfile

    def kerbfile
      @kerbfile ||= Kerbfile.read
    end

    def config
      Config.instance
    end

    def init_config
      config.load
      # ugly special handling for ckan source, since it also has the repositories.json
      Tempfile.open("ckan.tgz") do |f|
        f.write open(config[:sources][:default]).read
        f.close
        Dir.mktmpdir do |dir|
          extract_tgz(f.path, dir)
          ModCollection.from_dir(dir)  # FIXME: shovel this somewhere
          repositories = JSON.parse(IO.read(File.join(dir, "CKAN-meta-master", "repositories.json")))
          rep_hash = Hash[ repositories["repositories"].collect { |v| [ v["name"].downcase.gsub(/-/, "_").to_sym, v["uri"] ] } ]
          config[:sources] = config[:sources].merge(rep_hash)
        end
      end
    end

    def search
      init_config
      require "pp"
      pp config[:sources]
      pp kerbfile
    end
  end
end
