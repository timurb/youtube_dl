RSpec.describe Video, type: :entity do
  let(:video) { Video.new(state_id: VideoState.created) }

  it 'returns state as a number' do
    expect(video.state_id).to eq(VideoState.created)
  end

  it 'returns state as a symbol' do
    expect(video.state_text).to eq(:created)
  end
end
