module Mod
  # Mod Users Controller
  # Actions for interacting with users as a mod
  # Actions: Banned, Ban
  class UsersController < Mod::ApplicationController

    def banned
      banned_users = User.where(banned: true)
      @users = banned_users.paginate(page: params[:page], per_page: 10)
    end

    def ban
      User.friendly.find(params[:id]).ban!(current_user)

      redirect_to :back
    end

  end
end
