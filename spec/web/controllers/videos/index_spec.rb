RSpec.describe Web::Controllers::Videos::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:repository) { VideoRepository.new }

  before do
    repository.clear

    @video = repository.create(url: 'https://youtube.com/id=asd', status: 'new')
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
