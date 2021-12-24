RSpec.describe Web::Views::Videos::Index, type: :view do
  let(:exposures) { Hash[videos: []] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/videos/index.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  context 'when there are videos' do
    let(:video1) { Video.new(url:'https://youtube.com/id=asd', state_id: VideoState.created) }
    let(:exposures) { Hash[videos: [video1]] }

    it 'lists all videos' do
#       expect(rendered.scan(/class="video"/).length).to eq(1)
#       expect(rendered).to include('https://youtube.com/id=asd')
    end

    it 'hides placeholder message' do
      expect(rendered).to_not include('Пока нет видео')
    end
  end
end
