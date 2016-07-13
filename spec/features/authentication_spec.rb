feature 'Authentication' do
  let(:password) { Faker::Internet.password(8) }
  let(:user) { create(:user, password: password) }

  scenario 'signing up' do
    visit root_path
    click_link 'Sign Up'
    within first('form') do
      fill_in 'Name', with: Faker::Name.name
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Zip code', with: Faker::Address.zip_code
      fill_in 'Password', with: password
      fill_in 'Password Confirmation', with: password
      submit_form
    end

    expect(page).to have_content 'You have signed up successfully.'
  end

  scenario 'signing in' do
    visit root_path
    within('.nav.navbar-right') { click_link 'Sign In' }
    within first('form#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
      submit_form
    end
    expect(page).to have_content user.name
  end
end
