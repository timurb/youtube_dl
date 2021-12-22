RSpec.describe Web::Controllers::Videos::Create, type: :action do
  let(:action) { described_class.new }
  let(:locations) { LocationRepository.new }
  let(:repository)  { VideoRepository.new }

  before do
    repository.clear
    locations.clear

    @location = locations.create(path: 'path')
  end

  context 'with valid params' do
    let(:params) { Hash[ video: {url: 'https://youtube.com/id=asd', location_id: @location.id} ] }

    it 'creates a new video' do
      action.call(params)

      video = repository.last
      expect(video.id).to_not be_nil
    end

    it 'is successful' do
      response = action.call(params)
      expect(response[0]).to eq 302
      expect(response[1]['Location']).to eq('/videos')
    end
  end

  context 'with invalid params' do
    let(:params) { Hash[ video: {url: ''} ] }  ###FIXME

    it 'returns an error' do
      response = action.call(params)
      expect(response[0]).to eq 422
    end

    it 'describes the error to user' do
      response = action.call(params)
      errors = action.params.errors

      expect(errors.dig(:video, :url)).to eq(['is in invalid format'])
    end
  end

end
