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

    def filter(string = nil, name: nil, author: nil, identifier: nil, abstract: nil)
      ret = deep_dup
      ret.mods.select! { |x| r = case_insensitive_regexp(string); x.name =~ r || x.author =~ r || x.identifier =~ r  } unless string.nil?
      ret.mods.select! { |x| x.name =~ case_insensitive_regexp(name) } unless name.nil?
      ret.mods.select! { |x| x.author =~ case_insensitive_regexp(author) } unless author.nil?
      ret.mods.select! { |x| x.identifier =~ case_insensitive_regexp(identifier) } unless identifier.nil?
      ret.mods.select! { |x| x.abstract =~ case_insensitive_regexp(abstract) } unless abstract.nil?
      ret
    end

    def ksp_version_filter(min: nil, max: nil, exact: nil)
      ret = deep_dup
      ret.mods.select! { |x|
    end

    def deep_dup
      mc = self.class.new
      mc.mods = mods.map { |x| x.dup }
      mc
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

    private

    def case_insensitive_regexp(string)
      Regexp.new(Regexp.escape(string), Regexp::IGNORECASE)
    end

  end
end
