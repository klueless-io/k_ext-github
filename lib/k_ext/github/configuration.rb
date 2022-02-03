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
        @user = ENV['GH_USER'] || ENV['GITHUB_USER']
        @personal_access_token = ENV['GITHUB_PERSONAL_ACCESS_TOKEN']
        @personal_access_token_delete = ENV['GITHUB_PERSONAL_ACCESS_TOKEN_DELETE']
      end
    end
  end
end
