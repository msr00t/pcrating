class Admin::UsersController < Admin::ApplicationController

  def restore
    @user = User.find(params[:id])
    @user.banned = false
    Review.restore(@user.reviews.map(&:id))
    @user.save

    redirect_to :back
  end

end
