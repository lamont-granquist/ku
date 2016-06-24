module Ku
  module RestBase
    # need to supply fields method or override from_hash/to_hash/eql?
    def fields
      raise "must implement or override from_hash/to_hash/eql?"
    end

    def from_json(s)
      h = JSON.parse(s)
      from_hash(h)
    end

    def from_hash(h)
      fields.each do |str|
        send(:"#{str}=", h[str]) if h.key?(str)
      end
    end

    def to_file(filename)
      File.open(filename, "w+") do |f|
        f.write to_json
      end
    end

    def from_file(f)
      from_json(IO.read(f))
    end

    def from_uri(uri)
      from_json(open(uri.to_s).read)
    end

    def to_hash
      h = {}
      fields.each do |f|
        v = send(:"#{f}")
        h[f] = v unless v.nil?
      end
      h
    end

    def to_json(*o)
      JSON.generate(to_hash, *o)
    end

    def eql?(other)
      fields.all? do |f|
        send(:"#{f}").eql?(other.send(:"#{f}"))
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def from_json(s)
        mod = new
        mod.from_json(s)
        mod
      end

      def from_hash(h)
        mod = new
        mod.from_hash(h)
        mod
      end

      def from_file(f)
        mod = new
        mod.from_file(f)
        mod
      end

      def from_uri(uri)
        mod = new
        mod.from_uri(uri)
        mod
      end
    end
  end
end
