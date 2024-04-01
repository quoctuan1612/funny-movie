require 'rails_helper'

feature 'Visitor sign up' do
  scenario 'with valid credentials' do
    visit new_user_registration_path
    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: 'password'
    click_button 'commit'

    expect(page).to have_content('Welcome test@example.com')
  end

  scenario 'with invalid email' do
    visit new_user_registration_path
    fill_in 'user[email]', with: 'invalid_email'
    fill_in 'user[password]', with: 'password'
    click_button 'commit'

    expect(page).to have_content('Email is invalid')
  end
end
