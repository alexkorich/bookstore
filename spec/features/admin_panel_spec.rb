require 'features/features_spec_helper'


describe 'home page' do
  it 'welcomes the user' do
    visit '/'
    expect(page).to have_content('The Bookstore')
  end
end