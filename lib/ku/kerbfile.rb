module Ku
  class Kerbfile
    attr_accessor :sources

    def sources
      @sources ||= []
    end

    def source(src)
      sources.push(src)
    end

    def self.read
      kf = new
      kf.instance_eval(IO.read("Kerbfile"))
      kf
    end
  end
end
