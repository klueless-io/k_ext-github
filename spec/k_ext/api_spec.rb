# frozen_string_literal: true

require 'spec_helper'

# ----------------------------------------------------------------------
# GitHub API integration tests
#
# NOTE: Turn on integration tests using the following command in spec_helper
#   config.filter_run_excluding :integration_tests => false
# ----------------------------------------------------------------------
RSpec.describe KExt::Github::Api, :integration_tests do
  include KLog::Logging

  before { KExt::Github.reset }

  let(:config) { KExt::Github.configuration }

  let(:api) { KExt::Github::Api.new(token: config.personal_access_token) }
  let(:api_delete) { KExt::Github::Api.new(token: config.personal_access_token_delete) }

  let(:sample_repo) { 'klueless-io/z-test-aerial.com' }
  let(:test_repo_full_key) { 'klueless-io/z-test-kdsl' }
  let(:test_repo) { 'z-test-kdsl' }

  # ----------------------------------------------------------------------
  # Check/Debug factory data
  # ----------------------------------------------------------------------

  context 'factories' do
    it 'should instantiate' do
      git_api = KExt::Github::Api.new

      expect(git_api).to_not be_nil
    end
  end

  # --------------------------------------------------------------------------------
  # GIT HUB Tests
  # --------------------------------------------------------------------------------

  context 'authenticate' do
    # xit 'can authenticate with username/password' do
    #
    #   git_api = KExt::Github::Api.new
    #
    #   git_api.auth(login: 'david@ideasmen.com.au', password: 'ADD VALID PASSWORD')
    #
    #   expect(git_api.client).to_not be_nil
    #   expect(git_api.client.user).to_not be_nil
    #   expect(git_api.client.user.name).to eq('David Cruwys')
    #
    # end

    it 'can authenticate with personal access token' do
      git_api = KExt::Github::Api.new

      # https://github.com/settings/tokens/new
      client_id = config.personal_access_token

      git_api.auth(token: client_id)

      expect(git_api.client).to_not be_nil
      expect(git_api.client.user).to_not be_nil
      expect(git_api.client.user.name).to eq('David Cruwys')
    end
    #
    # it 'should instantiate and auth with username/password' do
    #   git_api = KExt::Github::Api.new(login: 'david@ideasmen.com.au', password: 'ADD VALID PASSWORD')
    #
    #   expect(git_api.client).to_not be_nil
    #   expect(git_api.client.user).to_not be_nil
    #   expect(git_api.client.user.name).to eq('David Cruwys')
    # end

    it 'should instantiate and auth with personal access token' do
      git_api = KExt::Github::Api.new(token: config.personal_access_token)

      expect(git_api.client).to_not be_nil
      expect(git_api.client.user).to_not be_nil
      expect(git_api.client.user.name).to eq('David Cruwys')
    end
  end

  describe 'repositories' do
    it 'get list of repositories' do
      repos = api.repositories

      expect(repos.count).to be > 0

      # KExt::Github::Printer.repositories_as_table(repos)
      # log.kv 'Repository Count', repos.count
    end

    it 'create a repositories' do
      # KExt::Github::Printer::p_repositories_as_table api.repositories

      api_delete.delete_repository(test_repo_full_key)
      repo = api.create_repository(test_repo)

      expect(repo).to_not be_nil

      # puts repo.inspect
      # KExt::Github::Printer::p_repositories_as_table api.repositories
    end

    it 'delete a repositories' do
      # KExt::Github::Printer::p_repositories_as_table api.repositories

      api_delete.delete_repository(test_repo_full_key)

      # KExt::Github::Printer::p_repositories_as_table api.repositories
    end

    context 'organization repo' do
      let(:test_repo_full_key) { 'klueless-csharp-samples/z-test-kdsl' }
      # let(:test_repo_full_key) { 'klueless-csharp-samples/p02_ef4' }

      it 'get list of repositories' do
        repos = api.organization_repositories('klueless-csharp-samples')

        expect(repos.count).to be > 0

        # KExt::Github::Printer.repositories_as_table repos
        log.kv 'Repository Count', repos.count
        # KExt::Github::Printer.repository(repos.first)
      end

      it 'delete/create a repository' do
        # KExt::Github::Printer::p_repositories_as_table api.repositories

        # klueless-csharp-samples/p02_ef4

        api_delete.delete_repository(test_repo_full_key, organization: 'klueless-csharp-samples')
        repo = api.create_repository(test_repo, organization: 'klueless-csharp-samples')

        expect(repo).to_not be_nil

        api_delete.delete_repository(test_repo_full_key, organization: 'klueless-csharp-samples')

        # KExt::Github::Printer::p_repositories_as_table api.repositories
      end
    end
  end

  describe 'repository hooks' do
    it 'get list of hooks on repository' do
      hooks = api.hooks(sample_repo)

      if hooks.count == 0
        log.info 'No webhooks found for repository'
      else
        KExt::Github::Printer.hooks_as_table hooks
      end

      # log.json hooks.first.config
    end

    it 'remove repository hooks' do
      api.remove_hooks(sample_repo)
    end

    it 'remove repository hooks one by one' do
      hooks = api.hooks(sample_repo)

      # log.heading 'before'
      # KExt::Github::Printer::p_hooks_as_table hooks

      hooks.each do |hook|
        api.remove_hook(repo, hook.id)
      end

      # log.heading 'after'
      # hooks = api.hooks(repo)
      # KExt::Github::Printer::p_hooks_as_table hooks
    end
  end
end
