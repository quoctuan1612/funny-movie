require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe Video, type: :model do
  describe 'callbacks' do
    it 'should enqueue a notification job after create' do
      user = FactoryBot.create(:user)
      video = FactoryBot.create(:video, user: user)
      expect(NotificationJob).to have_been_enqueued.with(video.user.email, video.title)
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    context 'uniqueness' do
      subject { FactoryBot.create(:video) }

      it { should validate_uniqueness_of(:video_id) }
    end

    context 'presence' do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:video_id) }
    end
  end
end
