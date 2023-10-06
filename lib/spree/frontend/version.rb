# frozen_string_literal: true

module Spree
  module Frontend
    VERSION = "4.0.0"

    def self.version
      VERSION
    end

    def self.gem_version
      Gem::Version.new(version)
    end
  end
end
