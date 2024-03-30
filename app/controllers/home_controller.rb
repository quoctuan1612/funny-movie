class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @videos = Video.all.order(created_at: :desc)
  end
end
