# frozen_string_literal: true

RSpec.describe KExt::Github::GitHubConfigurationExtension do
  let(:k_config) { KConfig }

  let(:cfg) { ->(config) {} }

  let(:instance) { k_config.configuration.github }

  before :each do
    k_config.configure(&cfg)
  end
  after :each do
    k_config.reset
  end

  describe '#configure' do
    describe '#user' do
      subject { instance.user }
    
      fit { is_expected.not_to be_empty }
    end
  end

  # context 'sample usage' do
  #   subject { instance.github.package_groups }
  #   let(:cfg) do
  #     lambda do |config|
  #       config.package_json.set_package_group('custom', 'Custom List of Packages', %w[package1 package2 package3])
  #     end
  #   end

  #   context ".package_group['custom']" do
  #     subject { instance.package_json.package_groups['custom'] }

  #     it do
  #       is_expected
  #         .to have_attributes(key: 'custom',
  #                             description: 'Custom List of Packages',
  #                             package_names: %w[package1 package2 package3])
  #     end
  #   end
  # end
end
