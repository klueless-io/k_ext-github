# frozen_string_literal: true

module KExt
  module Github
    # Print formatted log for GitHub data such as repositories
    require 'octokit'

    # The API provides a limited set of service methods for working against GitHub
    class Api
      include KLog::Logging
      include Virtus.model

      # attribute :client_id, String, :writer => :private
      # attribute :secret, String, :writer => :private

      # attribute :sites, Array[Netlify::Site], :writer => :private
      attribute :client, Octokit::Client, writer: :private

      def self.instance(access_token)
        GithubApi.new(token: access_token)
      end

      # Create API for communicating with GitHub
      #
      # Provide token OR login/password
      #
      # Create a token here
      # https://github.com/settings/tokens/new
      #
      # @param [String] token
      # @param [String] login
      # @param [String] password
      def initialize(token: nil, login: nil, password: nil)
        auth(token: token, login: login, password: password) if token || login || password
      end

      # Authenticate against GitHub with username and password or token
      #
      # Provide token OR login/password
      #
      # Create a token here
      # https://github.com/settings/tokens/new
      # @param [String] token
      # @param [String] login
      # @param [String] password
      def auth(token: nil, login: nil, password: nil)
        raise 'Provide credentials. Token or username/password' if token.nil? && (login.nil? || password.nil?)

        self.client = if token.nil?
                        Octokit::Client.new(login: login, password: password)
                      else
                        Octokit::Client.new(access_token: token)
                      end

        # Fetch the current user
        log.kv 'GitHub User', client.user.name
      end

      # --------------------------------------------------------------------------------
      # Service Actions
      # --------------------------------------------------------------------------------

      # list of repositories for this user
      #
      def repositories
        items = @client.repositories({}, query: { per_page: 100 })

        items.map { |item| KExt::Github::Models::Repository.new(item) }
      end

      # create repository
      #
      # @param [String] repository_name e.g. klueless-io/z-test-aerial.com
      def create_repository(repository_name, **options)
        @client.create_repository(repository_name, options)
      end

      # delete repository
      #
      # @param [String] repository_name e.g. klueless-io/z-test-aerial.com
      def delete_repository(repository_name, **options)
        @client.delete_repository(repository_name, **options)
      end

      # list of hooks for repository
      #
      # @param [String] repository_name e.g. klueless-io/z-test-aerial.com
      def hooks(repository_name)
        items = @client.hooks(repository_name)

        items.map { |item| KExt::Github::Models::Hook.new(item) }
      end

      # list of repositories for organization
      #
      # @param [String] org_name Organization name
      def organization_repositories(org_name)
        items = @client.repositories(org_name, query: { per_page: 100 })

        items.map { |item| KExt::Github::Models::Repository.new(item) }
      end
      # organization_repositories(org, options = {}) => Array<Sawyer::Resource> (also: #org_repositories, #org_repos)

      # remove hook from repository by id
      #
      # @param [String] repository_name e.g. klueless-io/z-test-aerial.com
      # @param [Integer] id hook ID
      def remove_hook(repository_name, id)
        @client.remove_hook(repository_name, id)
      end

      # remove all hooks in a repository
      #
      # @param [String] repository_name e.g. klueless-io/z-test-aerial.com
      def remove_hooks(repository_name)
        hooks = hooks(repository_name)

        hooks.each do |hook|
          @client.remove_hook(repository_name, hook.id)
        end
      end
    end
  end
end
