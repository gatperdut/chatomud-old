class AnnouncementsController < ApplicationController
  def index
    render json: Announcement.all
  end
end
