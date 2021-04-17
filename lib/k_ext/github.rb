# frozen_string_literal: true

require 'virtus'
require 'k_log'

require 'k_ext/github/version'
require 'k_ext/github/configuration'
require 'k_ext/github/models/hook'
require 'k_ext/github/models/owner'
require 'k_ext/github/models/repository'
require 'k_ext/github/printer'
require 'k_ext/github/api'

module KExt
  module Github
    # raise KExt::Github::Error, 'Sample message'
    class Error < StandardError; end

    class << self
      def configuration
        @configuration ||= KExt::Github::Configuration.new
      end

      def reset
        @configuration = KExt::Github::Configuration.new
      end

      def configure
        yield(configuration)
      end
    end
  end
end

if ENV['KLUE_DEBUG']&.to_s&.downcase == 'true'
  namespace = 'KExt::Github::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('k_ext/github/version') }
  version = KExt::Github::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
