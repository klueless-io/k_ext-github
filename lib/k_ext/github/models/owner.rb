# frozen_string_literal: true

module KExt
  module Github
    module Models
      # This model represents a GitHub owner
      class Owner
        include Virtus.model

        def initialize(attributes = nil)
          # Virtus will take your attributes and match them to the attribute definitions listed below
          super(attributes)
        end

        attribute :login, String
      end
    end
  end
end
