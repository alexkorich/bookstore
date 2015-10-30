require 'features/features_test_helper'
 



describe 'home page' do
  it 'welcomes the user' do
    visit '/'
    expect(page).to have_content('The Bookstore')
  end
end
describe 'admin page' do
  let(:user) {FactoryGirl.build(:user)}
  let(:admin) {FactoryGirl.build(:user, :admin)}
  let (:signup_user) {
    user
    visit '/users/sign_up/'
    within("#new_user") do
      fill_in 'user[firstname]', with: user.firstname
      fill_in 'user[lastname]', with: user.lastname
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password
      end
    click_button 'Sign up'
  }
  let (:signup_admin) {
      admin
      visit '/users/sign_up/'

      within("#new_user") do
      fill_in 'user[firstname]', with: admin.firstname
      fill_in 'user[lastname]', with: admin.lastname
      fill_in 'user[email]', with: admin.email
      fill_in 'user[password]', with: admin.password
      fill_in 'user[password_confirmation]', with: admin.password
      end
      click_button 'Sign up'
    }

  
    it 'greets new user' do
      signup_user
      expect(page).to have_content("Welcome")
    end    
  it 'redirects if not signed' do
    signup_user
    visit '/admin'
    expect(page).to have_content("Sorry. but you are not authorized to view this page")

  end
  it 'redirects if not admin' do
    signup_admin
    visit '/admin'
    expect(page).to have_content('Admin')
  end



end