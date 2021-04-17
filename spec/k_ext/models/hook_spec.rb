# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KExt::Github::Models::Hook do
  let(:instance) { described_class.new(attributes) }
  let(:attributes) { {} }

  context 'initialize' do
    subject { instance }

    it { is_expected.not_to be_nil }

    context '.name' do
      let(:attributes) { { name: :hook_name } }

      subject { instance.name }

      it { is_expected.to eq('hook_name') }
    end
  end
end
