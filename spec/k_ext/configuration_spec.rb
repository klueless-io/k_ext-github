# frozen_string_literal: true

require 'spec_helper'

# ----------------------------------------------------------------------
# GitHub API integration tests
#
# NOTE: Turn on integration tests using the following command in spec_helper
#   config.filter_run_excluding :integration_tests => false
# ----------------------------------------------------------------------
RSpec.describe KExt::Github::Configuration, :integration_tests do
  include KLog::Logging

  describe 'module helper' do
    subject { module_helper }

    let(:module_helper) { KExt::Github.configuration }

    # it { is_expected.not_to be_nil }

    describe '#configure' do
      before do
        KExt::Github.configure do |config|
          config.user = 'user'
          config.personal_access_token = 'pat'
          config.personal_access_token_delete = 'pat_d'
        end
      end

      it do
        is_expected.to have_attributes(
          user: 'user',
          personal_access_token: 'pat',
          personal_access_token_delete: 'pat_d'
        )
      end
    end
  end

  context 'initialize' do
    subject { instance }

    let(:instance) { described_class.new }

    it { is_expected.not_to be_nil }

    context '.user' do
      subject { instance.user }

      it { is_expected.not_to be_empty }
    end

    context '.personal_access_token' do
      subject { instance.personal_access_token }

      it { is_expected.not_to be_empty }
    end

    context '.personal_access_token_delete' do
      subject { instance.personal_access_token_delete }

      it { is_expected.not_to be_empty }
    end
  end
end
