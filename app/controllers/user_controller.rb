# Users Controller
# Actions for interacting with the various users on the site
# Actions: Show, Report
class UserController < ApplicationController

  def show
    @user = User.friendly.find(params[:id])

    if @user
      @reviews = @user.reviews.paginate(page: params[:page])
    else
      redirect_to root_path
    end
  end

  def report
    @user = User.find_by(id: params[:user_id])
    @user.report!(current_user) if @user

    respond_to do |format|
      format.js { true }
    end
  end

end
