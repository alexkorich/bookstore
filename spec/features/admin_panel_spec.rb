require 'features/features_test_helper'
 



describe 'home page' do
  it 'welcomes the user' do
    visit '/'
    expect(page).to have_content('The Bookstore')
  end
end
context 'admin page' do
  let(:admin) {FactoryGirl.create(:user, :admin)}
  
  let (:signin_admin) {
      admin
      visit '/users/sign_in/'
      within("#new_user") do
      fill_in 'user[email]', with: admin.email
      fill_in 'user[password]', with: admin.password
      end
      click_button 'Log in'
    }
  let(:to_books)
  let(:to_authors)
  let(:to_categories)
  let(:to_orders)

  it 'could be accessed if user admin' do
    signin_admin
    visit '/admin'
    expect(page).to have_content('Site Administration')
  end
  describe 'books' do
    it 's control could be accessed' do
      signin_admin
      visit '/admin'
      expect(page).to have_link('Books')
    end
    it 'could be created' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Books")
      end
      expect(page).to have_content("Add new")
    end

     it '.create' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Authors")
      end
      expect(page).to have_content("Add new")
    end
    it '.read' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Authors")
      end
      expect(page).to have_content("Add new")
    end

     it '.update' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Authors")
      end
      expect(page).to have_content("Add new")
    end
     it '.delete' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Authors")
      end
      expect(page).to have_content("Add new")
    end





  end

  describe 'author' do
    it 'control could be accessed' do
      signin_admin
      visit '/admin'
      expect(page).to have_link('Authors')
    end
    it 'could be created' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Authors")
      end
      expect(page).to have_content("Add new")
    end
    it '.create' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Authors")
      end
      expect(page).to have_content("Add new")
    end
    it '.read' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Authors")
      end
      expect(page).to have_content("Add new")
    end

     it '.update' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Authors")
      end
      expect(page).to have_content("Add new")
    end
     it '.delete' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Authors")
      end
      expect(page).to have_content("Add new")
    end








  end
  describe 'category' do
    it 'control could be accessed' do
      signin_admin
      visit '/admin'
      expect(page).to have_link('Categories')
    end
    it 'could be created' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Categories")
      end
      expect(page).to have_content("Add new")
    end

     it '.create' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Authors")
      end
      expect(page).to have_content("Add new")
    end
    it '.read' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Authors")
      end
      expect(page).to have_content("Add new")
    end

     it '.update' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Authors")
      end
      expect(page).to have_content("Add new")
    end
     it '.delete' do
      signin_admin
      visit '/admin'
      within(".content") do
        click_link("Authors")
      end
      expect(page).to have_content("Add new")
    end
  end

  describe 'orders' do
    
  end

  describe 'reviews' do
    
  end

end