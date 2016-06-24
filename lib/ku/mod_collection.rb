require "ku/mod"
require "open-uri"
require "tempfile"
require "tmpdir"
require "ku/util/extract_tgz"
require "ku/rest_base"

module Ku
  class ModCollection
    attr_accessor :mods
    include Ku::Util::ExtractTgz
    include RestBase

    def mods
      @mods ||= []
    end

    def from_dir(dir)
      Dir.glob(File.join(File.expand_path(dir), "**", "*.ckan")) do |f|
        next unless File.file?(f)
        mods.push Mod.from_file(f)
      end
    end

    def fields
      %w{mods}
    end

    def self.from_dir(dir)
      mc = new
      mc.from_dir(dir)
      mc
    end

    def from_tgz(file)
      Dir.mktmpdir do |dir|
        extract_tgz(file, dir)
        from_dir(dir)
      end
    end

    def self.from_tgz(file)
      mc = new
      mc.from_tgz(file)
      mc
    end

    def from_uri(uri)
      Tempfile.open("ku.tgz") do |f|
        f.write open(uri.to_s).read
        f.close
        from_tgz(f.path)
      end
    end

    def self.from_uri(uri)
      mc = new
      mc.from_uri(uri)
      mc
    end

    def to_s
      lines = []
      mods.each do |mod|
        lines << [ mod.identifier, mod.version, mod.author, mod.name ].join(", ")
      end
      lines.join("\n")
    end
  end
end
