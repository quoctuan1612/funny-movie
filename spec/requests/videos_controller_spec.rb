require 'rails_helper'

RSpec.describe VideosController, type: :request do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'when video is existed' do
      before do
        allow_any_instance_of(Video).to receive(:persisted?).and_return(true)
      end

      it 'redirects to new video path' do
        post '/videos', params: { url: 'https://www.youtube.com/watch?v=123' }
        expect(response).to redirect_to(new_video_path)
        expect(flash[:danger]).to eq('Video was shared!')
      end
    end

    context 'when video is not found' do
      it 'redirects to new video path' do
        post '/videos', params: { url: 'https://www.youtube.com/watch?v=456' }
        expect(response).to redirect_to(new_video_path)
        expect(flash[:danger]).to eq('Video not found!')
      end
    end

    context 'when video is saved successfully' do
      before do
        allow(RestClient).to receive(:get).and_return(OpenStruct.new(body: { items: [{ snippet: { title: 'Title', description: 'Description' } }] }.to_json))
      end

      it 'redirects to root path' do
        post '/videos', params: { url: 'https://www.youtube.com/watch?v=789' }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when video save fails' do
      before do
        allow_any_instance_of(Video).to receive(:save).and_return(false)
        allow(RestClient).to receive(:get).and_return(OpenStruct.new(body: { items: [{ snippet: { title: 'Title', description: 'Description' } }] }.to_json))
      end

      it 'redirects to new video path' do
        post '/videos', params: { url: 'https://www.youtube.com/watch?v=999' }
        expect(response).to redirect_to(new_video_path)
        expect(flash[:danger]).to eq('Save failed!')
      end
    end
  end
end
