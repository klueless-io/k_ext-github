# frozen_string_literal: true

RSpec.describe KExt::Github::GitHubConfigurationExtension do
  let(:k_config) { KConfig }

  let(:cfg) { ->(config) {} }

  let(:github_config) { k_config.configuration.github }

  before :each do
    k_config.configure(&cfg)
  end
  after :each do
    k_config.reset
  end

  context 'default configuration will load from environment' do
    describe '.user' do
      subject { github_config.user }

      it { is_expected.not_to be_empty }
    end
    describe '.personal_access_token' do
      subject { github_config.personal_access_token }

      it { is_expected.not_to be_empty }
    end
    describe '.personal_access_token_delete' do
      subject { github_config.personal_access_token_delete }

      it { is_expected.not_to be_empty }
    end
  end

  context 'with custom configure' do
    subject { github_config }
    let(:cfg) do
      lambda do |config|
        config.github.user = 'user'
        config.github.personal_access_token = 'pat'
        config.github.personal_access_token_delete = 'pat_delete'
      end
    end

    it do
      is_expected.to have_attributes(
        user: 'user',
        personal_access_token: 'pat',
        personal_access_token_delete: 'pat_delete'
      )
    end
  end
end
