class UserController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.paginate(page: params[:page])
  end

  def ban
    if current_user.admin?
      @user = User.find(params[:user_id])
      @user.banned = true
      @user.reviews.delete_all
      @user.save
    end

    redirect_to root_path
  end

end
