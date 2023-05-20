class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    puts @user.recent_posts.inspect
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:success] = 'Successfully created...'
      redirect_to users_path
    else
      flash.now[:alert] = "Couldn't be deleted"
    end
  end
end