# frozen_string_literal: true

module KExt
  module Github
    # Configuration class for KExt::Github
    class Configuration
      include KUtil::Data::InstanceVariablesToH

      attr_accessor :user
      attr_accessor :personal_access_token
      attr_accessor :personal_access_token_delete

      def initialize
        @user = ENV.fetch('GH_USER') { ENV.fetch('GITHUB_USER', nil) }
        @personal_access_token = ENV.fetch('GITHUB_PERSONAL_ACCESS_TOKEN', nil)
        @personal_access_token_delete = ENV.fetch('GITHUB_PERSONAL_ACCESS_TOKEN_DELETE', nil)
      end
    end
  end
end
