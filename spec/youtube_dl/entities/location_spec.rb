RSpec.describe Location, type: :entity do
  it 'can be created with path' do
    location = Location.new(path: '/multiki')
    expect(location.path).to eq('/multiki')
  end
end
