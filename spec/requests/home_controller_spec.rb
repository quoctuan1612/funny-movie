require 'rails_helper'

RSpec.describe HomeController, type: :request do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }

  describe 'GET #index' do
    it 'requires authentication' do
      get '/'
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'returns a successful response' do
      sign_in user
      get '/'
      expect(response).to be_successful
    end

    it 'assigns @videos with all videos in descending order' do
      sign_in user

      user = FactoryBot.create(:user)
      video1 = FactoryBot.create(:video, video_id: 1, user: user)
      video2 = FactoryBot.create(:video, video_id: 2, user: user)
      video3 = FactoryBot.create(:video, video_id: 3, user: user)
      videos = [video1, video2, video3]

      get '/'
      expect(assigns(:videos)).to eq(videos.reverse)
    end
  end
end
