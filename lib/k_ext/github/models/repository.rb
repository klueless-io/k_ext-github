# frozen_string_literal: true

module KExt
  module Github
    module Models
      # This model represents a GitHub Repository
      class Repository
        include Virtus.model

        def initialize(attributes = nil)
          # Virtus will take your attributes and match them to the attribute definitions listed below
          super(attributes)
        end

        attribute :id, String
        attribute :node_id, String
        attribute :name, String
        attribute :full_name, String
        attribute :private, String
        attribute :description, String
        attribute :url, String
        attribute :created_at, String
        attribute :updated_at, String
        attribute :pushed_at, String
        attribute :git_url, String
        attribute :owner, KExt::Github::Models::Owner
      end
    end
  end
end
