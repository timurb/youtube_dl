RSpec.describe VideoInfo, type: :entity do
  let(:video_from_youtube) { JSON.parse(File.read("#{File.dirname(__FILE__)}/fixtures/video_from_youtube.json")) }

  it 'can be created with json' do
    video_info = VideoInfo.create_from_youtube(video_from_youtube)

    expect(video_info.youtube_id).to eq('U1eVbr3fvAQ')
    expect(video_info.title).to eq("Igorrr - Paranoid Bulldozer Italiano (Caen - BBC - 25/11/2021)")
    expect(video_info.thumbnail).to eq("https://i.ytimg.com/vi_webp/U1eVbr3fvAQ/maxresdefault.webp")
    expect(video_info.description).to eq("Igorrr - Paranoid Bulldozer Italiano (Caen - BigBandCafé - 25/11/2021)")
    expect(video_info.duration).to eq(101)
    expect(video_info.filename).to eq("Igorrr - Paranoid Bulldozer Italiano (Caen - BBC - 25_11_2021)-U1eVbr3fvAQ.mp4")
    expect(video_info.uploader).to eq("alphaXire")
    expect(video_info.uploader_url).to eq("http://www.youtube.com/channel/UCestxxfaIn50yV0P5xkTQgA")
    expect(video_info.channel).to eq("alphaXire")
    expect(video_info.channel_url).to eq("https://www.youtube.com/channel/UCestxxfaIn50yV0P5xkTQgA")
  end
end