# spec/features/home_spec.rb

feature 'Homepage Features' do
  before { visit root_path }

  # it won't run js code but it is fast
  context 'visit home page' do
    it 'have conntent of page' do
      expect(page).to have_content 'No movies'
    end

    it 'have footer page' do
      expect(page).to have_content '© 2021 · c2nptech@gmail.com'
    end

    it 'register user success' do
      fill_in 'user_email', with: 'c2nptech@gmail.com'
      fill_in 'user_password', with: '123456'
      click_on 'Login / Register'
      expect(page).to have_content 'No movies'
      expect(page).to have_content 'Share a movie'
    end

    it 'register user success', :js do
      fill_in 'user_email', with: 'c2nptech@gmail.com'
      fill_in 'user_password', with: '123456'
      click_on 'Login / Register'
      expect(page).to have_content 'You have been access successfully!'
    end

    it 'sign in with no enter password', :js do
      fill_in 'user_email', with: 'c2nptech@gmail.com'
      fill_in 'user_password', with: ''
      click_on 'Login / Register'
      expect(page).to have_content 'Invalid email or password. Please try again!'
    end

    it 'Email and password is blank', :js do
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      click_on 'Login / Register'
      expect(page).to have_content 'Invalid email or password. Please try again!'
    end

    it 'Email is blank', :js do
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: '1234567'
      click_on 'Login / Register'
      expect(page).to have_content 'Invalid email or password. Please try again!'
    end

    # it will run js code
    it '', :js do
      expect(page).to have_content 'No movies'
    end
  end
end
