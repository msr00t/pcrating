class Mod::UsersController < Mod::ApplicationController

  def banned
    @users = User.where(banned: true).paginate(page: params[:page], per_page: 10)
  end

  def ban
    User.find(params[:id]).ban!(current_user)

    redirect_to :back
  end

end
