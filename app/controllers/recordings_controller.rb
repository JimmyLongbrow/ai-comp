class RecordingsController < ApplicationController
  before_action :check_if_logged_in
  def new
    @recording = Recording.new
  end

  def create
    @recording = Recording.new recording_params
    @recording.user_id = @current_user.id
    if params[:file].present?
      #foward uploaded file onto Cloudinary Server
      response = Cloudinary::Uploader.upload(params[:file],:resource_type => :video)
      @recording.file = response['public_id']
    end
    @recording.save
    redirect_to recording_path(@recording.id)
  end

  def index
    @recordings = Recording.all
  end

  def show
    @recording = Recording.find params[:id]
  end

  def edit
    @recording = Recording.find params[:id]
  end

  def update
    @recording = Recording.find params[:id]
    recording.update recording_path
    redirect_to( recording_path(params[:id]) )
  end

  def destroy
    Recording.destroy params[:id]
    redirect_to recordings_path
  end

  private

  def recording_params
    params.require(:recording).permit(:file, :comments, :sequence_id)
  end
end
