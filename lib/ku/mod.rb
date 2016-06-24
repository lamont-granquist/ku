require "json"
require "open-uri"
require "ku/rest_base"

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

    def fields
      %w{ spec_version identifier name abstract author license resources version ksp_version_min ksp_version_max
          install download download_size download_hash download_content_type depends recommends suggests x_generated_by }.freeze
    end

    include RestBase
  end
end
