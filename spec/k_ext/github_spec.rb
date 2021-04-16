# frozen_string_literal: true

RSpec.describe KExt::Github do
  it 'has a version number' do
    expect(KExt::Github::VERSION).not_to be nil
  end

  it 'has a standard error' do
    expect { raise KExt::Github::Error, 'some message' }
      .to raise_error('some message')
  end
end
