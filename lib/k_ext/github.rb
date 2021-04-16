# frozen_string_literal: true

require 'k_ext/github/version'

module KExt
  module Github
    # raise KExt::Github::Error, 'Sample message'
    class Error < StandardError; end

    # Your code goes here...
  end
end

if ENV['KLUE_DEBUG']&.to_s&.downcase == 'true'
  namespace = 'KExtGithub::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('k_ext/github/version') }
  version = KExtGithub::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
