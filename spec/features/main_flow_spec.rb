require 'rails_helper'

feature 'Main flow valid' do
  let!(:user) { create(:user) }
  before do
    allow(RestClient).to receive(:get).and_return(OpenStruct.new(body: { items: [{ snippet: { title: 'PSY - GANGNAM STYLE(강남스타일) M/V', description: 'PSY - ‘I LUV IT’ M/V @ https://youtu.be/Xvjnoagk6GU PSY - ‘New Face’ M/V' } }] }.to_json))
  end

  scenario 'User shares a new video' do
    visit new_user_session_path
    fill_in 'user[email]', with: 'test@gmail.com'
    fill_in 'user[password]', with: '123456'
    click_button 'commit'

    expect(page).to have_content('Welcome test@gmail.com')
    expect(page).to have_content('Share a movie')

    page.find("#share").click
    expect(page).to have_content('Share a Youtube movie')
    expect(page).to have_content('Youtube URL:')

    fill_in 'url', with: 'https://www.youtube.com/watch?v=9bZkp7q19f0'
    click_button 'button'

    expect(page).to have_content('PSY - GANGNAM STYLE(강남스타일) M/V')
    expect(page).to have_content('PSY - ‘I LUV IT’ M/V @ https://youtu.be/Xvjnoagk6GU PSY - ‘New Face’ M/V')
    expect(page).to have_content("Shared by: #{user.email}")
  end
end
