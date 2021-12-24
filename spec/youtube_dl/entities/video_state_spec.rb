RSpec.describe VideoState, type: :entity do
  it 'has values' do
    expect(VideoState).to respond_to(:created)
  end

  it 'has class matchers' do
    expect(VideoState).to respond_to(:active?)
    expect(VideoState).to respond_to(:pending?)
    expect(VideoState).to respond_to(:error?)
    expect(VideoState).to respond_to(:completed?)
    expect(VideoState).to respond_to(:deleted?)
  end

  it 'accepts constants for matching' do
    expect(VideoState.active?(VideoState.processing)).to be true
    expect(VideoState.deleted?(VideoState.deleted)).to be true
  end

  it 'accepts symbols for matching' do
    expect(VideoState.active?(:processing)).to be true
    expect(VideoState.deleted?(:deleted)).to be true
  end
end