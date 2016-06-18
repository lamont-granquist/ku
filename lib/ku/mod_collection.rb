require "ku/mod"

module Ku
  class ModCollection
    attr_accessor :mods

    def mods
      @mods ||= []
    end

    def from_dir(dir)
      Dir.glob(File.join(File.expand_path(dir), "**", "*.ckan")) do |f|
        next unless File.file?(f)
        mods.push Mod.from_file(f)
      end
    end

    def self.from_dir(dir)
      mc = new
      mc.from_dir(dir)
      mc
    end

    def from_json(s)
      h = JSON.parse(s)
      from_hash(h)
    end

    def self.from_json(s)
      mc = new
      mc.from_json(s)
      mc
    end

    def from_hash(h)
      self.mods = h["mods"] if h.key?("mods")
    end

    def self.from_hash(h)
      mc = new
      mc.from_hash(h)
      mc
    end

    def from_file(f)
      from_json(IO.read(f))
    end

    def self.from_file(f)
      mc = new
      mc.from_file(f)
      mc
    end

    def to_hash
      {
        "mods" => mods.to_hash,
      }
    end

    def to_json(*o)
      JSON.generate(to_hash, *o)
    end

    def eql?(other)
      mods.eql?(other.mods)
    end
  end
end
