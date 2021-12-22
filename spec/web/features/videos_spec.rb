require 'features_helper'

RSpec.describe 'Visit videos page' do
  let(:repository) { VideoRepository.new }

  before do
    repository.clear

    repository.create(url: 'https://youtube.com/id=asd', status: 'new')
  end

  it 'is successful' do
    visit '/videos'

    within '#videos' do
      expect(page).to have_css('.video', count: 1), 'Expected to find 1 video'
      expect(page).to have_content('https://youtube.com/id=asd')
    end
  end
end