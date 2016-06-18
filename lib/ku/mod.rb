require "json"
require "open-uri"

module Ku
  class Mod
    # @returns [String]
    attr_accessor :spec_version
    # @returns [String]
    attr_accessor :identifier
    # @returns [String]
    attr_accessor :name
    # @returns [String]
    attr_accessor :abstract
    # @returns [Array]
    attr_accessor :author
    # @returns [String]
    attr_accessor :license
    # @returns [String]
    attr_accessor :resources
    # @returns [String]
    attr_accessor :version
    # @returns [String]
    attr_accessor :ksp_version_min
    # @returns [String]
    attr_accessor :ksp_version_max
    # @returns [String]
    attr_accessor :install
    # @returns [String]
    attr_accessor :download
    # @returns [String]
    attr_accessor :download_size
    # @returns [Hash]
    attr_accessor :download_hash
    # @returns [String]
    attr_accessor :download_content_type
    # @returns [Array<Hash>]
    attr_accessor :depends
    # @returns [Array<Hash>]
    attr_accessor :recommends
    # @returns [Array<Hash>]
    attr_accessor :suggests
    # @returns [String]
    attr_accessor :x_generated_by

    FIELDS = %w{ spec_version identifier name abstract author license resources version ksp_version_min ksp_version_max
                 install download download_size download_hash download_content_type depends recommends suggests x_generated_by }.freeze

    def from_json(s)
      h = JSON.parse(s)
      from_hash(h)
    end

    def self.from_json(s)
      mod = new
      mod.from_json(s)
      mod
    end

    def from_hash(h)
      FIELDS.each do |str|
        send(:"#{str}=", h[str]) if h.key?(str)
      end
    end

    def self.from_hash(h)
      mod = new
      mod.from_hash(h)
      mod
    end

    def to_file(filename)
      File.open(filename, "w+") do |f|
        f.write to_json
      end
    end

    def from_file(f)
      from_json(IO.read(f))
    end

    def self.from_file(f)
      mod = new
      mod.from_file(f)
      mod
    end

    def from_uri(uri)
      from_json(open(uri.to_s).read)
    end

    def self.from_uri(uri)
      mod = new
      mod.from_uri(uri)
      mod
    end

    def to_hash
      h = {}
      FIELDS.each do |f|
        v = send(:"#{f}")
        h[f] = v unless v.nil?
      end
      h
    end

    def to_json(*o)
      JSON.generate(to_hash, *o)
    end

    def eql?(other)
      FIELDS.all? do |f|
        send(:"#{f}").eql?(other.send(:"#{f}"))
      end
    end
  end
end
