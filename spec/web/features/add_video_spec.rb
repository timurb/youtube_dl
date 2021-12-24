require 'features_helper'

RSpec.describe 'Add video' do
  let(:repository) { VideoRepository.new }
  let!(:locations) { LocationRepository.new }

  before do
    repository.clear

    @location = locations.create(path: 'path')
  end

  it 'is successful' do
    visit '/videos/new'

    within 'form#video-form' do
      fill_in 'Url', with: 'https://youtube.com/id=asd'

      click_button 'Скачать'
    end

#     expect(page).to have_css('.video', count: 1), 'Expected to find 1 video'
#     expect(page).to have_content('https://youtube.com/id=asd')
  end
end