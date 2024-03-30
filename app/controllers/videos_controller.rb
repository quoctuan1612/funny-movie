class VideosController < ApplicationController
  before_action :authenticate_user!

  def create
    id = get_video_id
    video = Video.find_or_initialize_by(video_id: id)

    if video.persisted?
      flash[:danger] = "Video was shared!"
      return redirect_to new_video_path
    end

    video_info = get_video_info(id)

    if video_info.blank?
      flash[:danger] = "Video not found!"
      return redirect_to new_video_path
    end

    video.title = video_info.title
    video.description = video_info.description
    video.user = current_user

    if video.save
      redirect_to root_path
    else
      flash[:danger] = "Save failed!"
      redirect_to new_video_path
    end
  end

  private

  def get_video_info id
    response = RestClient.get("https://www.googleapis.com/youtube/v3/videos", {
      params: {
        id: id,
        key: "AIzaSyCex9Ka5iGzKL78vzFOrTWELHutwyrdpOM",
        part: "snippet"
      }
    }).body

    JSON.parse(response, object_class: OpenStruct).items&.first&.snippet
  end

  def get_video_id
    url = params[:url]

    return nil if url.blank?

    if url.include?("https://youtu.be")
      url.split("?")&.first&.split("/")&.last
    elsif url.include?("https://www.youtube.com")
      url.split("=")&.last
    else
      nil
    end
  end
end
