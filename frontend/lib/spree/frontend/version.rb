# frozen_string_literal: true

module Spree
  module Frontend
    VERSION = "3.2.0.alpha"

    def self.version
      VERSION
    end

    def self.minor_version
      '3.0'
    end

    def self.gem_version
      Gem::Version.new(version)
    end
  end
end
