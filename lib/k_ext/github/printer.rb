# frozen_string_literal: true

module KExt
  module Github
    # Print formatted log for GitHub data such as repositories
    class Printer
      extend KLog::Logging

      # ---------------------------------------------
      # Print Repositories
      # ---------------------------------------------

      def self.repositories(rows = nil, format = 'default')
        log.block 'Repositories'

        if rows.nil?
          Repository.all.each do |_r|
            repository_with_format(repo, format)
          end
        else
          rows.each do |_r|
            repository_with_format(repo, format)
          end
        end
      end

      def self.repositories_as_table(rows = nil, format = 'default')
        log.block 'Repositories'

        rows = Repository.all if rows.nil?

        case format
        when 'detailed'
          # tp rows
          tp rows, :id, :node_id, :name, :full_name, :private, :description, :url, 'owner.login', :created_at, :updated_at, :pushed_at, :git_url
        else
          tp rows, :id, :name, :git_url, :full_name, :private, :description, :url, 'owner.login'
        end
      end

      def self.repository_with_format(repo, format)
        case format
        when 'detailed'
          repository_detailed(repo)
        else
          repository(repo)
        end
      end

      def self.repository(repo)
        data = repo_key_values(repo)

        log.kv_hash(data)
        log.line
      end

      def self.repository_detailed(repo)
        data = repo_key_values(repo)

        log.kv_hash(data)
        log.line

        # Print Relations

        log.line
      end

      # ---------------------------------------------
      # Print Hooks
      # ---------------------------------------------

      def self.hooks(rows = nil, format = 'default')
        log.block 'Hooks'

        if rows.nil?
          Hook.all.each do |_r|
            hook_with_format(repo, format)
          end
        else
          rows.each do |_r|
            hook_with_format(repo, format)
          end
        end
      end

      def self.hooks_as_table(rows = nil, format = 'default')
        log.block 'Hooks'

        rows = Hook.all if rows.nil?

        case format
        when 'detailed'
          tp rows, :type, :id, :name, :active, :events, :config, :updated_at, :created_at, :url, :test_url, :ping_url, :last_response
        else
          tp rows, :type, :id, :name, :active, :url, :config
        end
      end

      def self.hook_with_format(repo, format)
        case format
        when 'detailed'
          hook_detailed(repo)
        else
          hook(repo)
        end
      end

      def self.hook(hook)
        hook_key_values(hook).each do |key_value|
          log.kv key_value.key, key_value.vale
        end

        log.line
      end

      def self.hook_detailed(hook)
        hook_key_values(hook).each do |key_value|
          log.kv key_value.key, key_value.vale
        end

        # Print Relations

        log.line
      end

      def self.repo_key_values(repo)
        {
          id: repo.id,
          node_id: repo.node_id,
          name: repo.name,
          full_name: repo.full_name,
          private: repo.private,
          description: repo.description,
          url: repo.url,
          created_at: repo.created_at,
          updated_at: repo.updated_at,
          pushed_at: repo.pushed_at,
          git_url: repo.git_url
        }
      end

      def self.hook_key_values(hook)
        {
          type: hook.type,
          id: hook.id,
          name: hook.name,
          active: hook.active,
          events: hook.events,
          config: hook.config,
          updated_at: hook.updated_at,
          created_at: hook.created_at,
          url: hook.url,
          test_url: hook.test_url,
          ping_url: hook.ping_url,
          last_response: hook.last_response
        }
      end
    end
  end
end
