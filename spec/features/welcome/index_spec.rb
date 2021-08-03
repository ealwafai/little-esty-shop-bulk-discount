require 'rails_helper'

RSpec.describe 'Welcome Index Page' do
  before :each do
    visit '/'
  end

  it 'shows the name of the project' do
    expect(page).to have_content('Little Esty Shop')
  end
end
