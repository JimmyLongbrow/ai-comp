class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create user_params
    #handle image upload
    if params[:file].present?
      #foward uploaded file onto Cloudinary Server
      response = Cloudinary::Uploader.upload params[:file]
      @user.profile_pic = response['public_id']
      @user.save
    end
    # if user.save
    #    UserMailer.registration_confirmation(@user).deliver
    #    flash[:success] = "Please confirm your email address to continue"
    #    redirect_to root_path
    # else
    #    flash[:error] = "Ooooppss, something went wrong!"
    #    render :new
    # end
    if @user.persisted?
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end

  end #create

  def index
    @user = User.all
  end

  def show
    @user = User.all
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    #check user is editing their own account
    if @user != @current_user
      redirect_to login_path
      return
    end
    if params[:file].present?
      #foward uploaded file onto Cloudinary Server
      response = Cloudinary::Uploader.upload params[:file]
      @user.profile_pic = response['public_id']
      @user.save
    end

    #
    # #check empty password fields
    # user_update_fields = user_params
    # if user_update_fields[:password].empty? && user_update_fields[:password_confirmation].empty?
    #   #remove empty password keys to avoid validation errors when password is left unchanged.
    #   user_update_fields.delete :password
    #   user_update_fields.delete :password_confirmation
    # end
    # result=
    # raise
    if @user.update user_params
      redirect_to user_path(@user)
    else
      #update returned false which means validation failed
      render :edit
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to login_path
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the AI-Comp! Your email has been confirmed.
      Please sign in to continue."
      redirect_to login_path
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to login_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :genre, :password, :password_confirmation)
  end
end
