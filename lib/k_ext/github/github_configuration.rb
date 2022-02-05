# frozen_string_literal: true

# Attach configuration to the KConfig module
module KExt
  module Github
    # GitHub configuration extension for attachment to KConfig::Configuration
    module GitHubConfigurationExtension
      def github
        @github ||= GitHubConfiguration.new
      end

      def github_debug
        github.debug
      end
    end

    # GitHub Configuration
    class GitHubConfiguration
      include KUtil::Data::InstanceVariablesToH
      include KLog::Logging

      attr_accessor :user
      attr_accessor :personal_access_token
      attr_accessor :personal_access_token_delete

      def initialize
        @user = ENV['GH_USER'] || ENV['GITHUB_USER']
        @personal_access_token = ENV['GITHUB_PERSONAL_ACCESS_TOKEN']
        @personal_access_token_delete = ENV['GITHUB_PERSONAL_ACCESS_TOKEN_DELETE']
      end

      def debug
        log.section_heading 'GitHub Configuration'
        log.kv 'user', user
        log.kv 'personal_access_token', '***'
        log.kv 'personal_access_token_delete', '***'
      end
    end
  end
end

KConfig::Configuration.register(:github, KExt::Github::GitHubConfigurationExtension)
