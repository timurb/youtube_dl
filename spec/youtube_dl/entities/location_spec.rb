require "anyway/testing/helpers"

RSpec.describe Location, type: :entity do
  it 'can be created with path' do
    location = Location.new(path: '/multiki')
    expect(location.path).to eq('/multiki')
  end

    it 'has full path' do
      with_env('YOUTUBEDL_BASE_PATH' => 'base_path') do
        location = Location.new(path: '/multiki')
        expect(location.full_path).to eq('base_path/multiki')
      end
    end
end
