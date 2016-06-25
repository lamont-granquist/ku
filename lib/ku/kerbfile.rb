module Ku
  class Kerbfile
    attr_accessor :sources
    attr_accessor :min_ksp_version

    NULL = Object.new

    def sources
      @sources ||= []
    end

    def source(src)
      sources.push(src)
    end

    def min_ksp_version(str = NULL)
      @min_ksp_version = str unless str == NULL
      @min_ksp_version
    end

    def self.read
      kf = new
      path = File.expand_path("Kerbfile")
      str = IO.read(path)
      kf.instance_eval(str, path)
      kf
    end
  end
end
