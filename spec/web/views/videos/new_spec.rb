RSpec.describe Web::Views::Videos::New, type: :view do
  let(:params)    { OpenStruct.new(valid?: false, error_messages: ['Url must be filled'])}
  let(:exposures) { Hash[params: params] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/videos/new.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'displays validation errors' do
    expect(rendered).to include('Url must be filled')
  end
end
