require 'rails_helper'

RSpec.describe 'Admin Deshboard/Index page' do
  it 'displays admin dashboard header' do
    visit admin__index_path
    expect(page).to have_content('Welcome to the Admin Dashboard')
  end
  # As an admin,
  # When I visit the admin dashboard (/admin)
  # Then I see a header indicating that I am on the admin dashboard
end