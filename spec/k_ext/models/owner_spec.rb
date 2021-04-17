# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KExt::Github::Models::Owner do
  let(:instance) { described_class.new(attributes) }
  let(:attributes) { {} }

  context 'initialize' do
    subject { instance }

    it { is_expected.not_to be_nil }

    context '.login' do
      let(:attributes) { { login: :user_or_org_name } }

      subject { instance.login }

      it { is_expected.to eq('user_or_org_name') }
    end
  end
end
