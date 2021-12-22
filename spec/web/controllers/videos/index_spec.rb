RSpec.describe Web::Controllers::Videos::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:locations) { LocationRepository.new }
  let(:repository) { VideoRepository.new }

  before do
    repository.clear
    locations.clear

    @location = locations.create(path: 'path')
    @video = repository.create(url: 'https://youtube.com/id=asd', state: VideoState.created, location_id: @location.id)
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end

  it 'exposes all videos' do
    action.call(params)
    expect(action.exposures[:videos]).to eq([@video])
  end
end
