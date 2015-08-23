module Admin
  # Admin Users Controller
  # Actions for interacting with Users as an admin
  # Actions: Restore
  class UsersController < Admin::ApplicationController

    def restore
      @user = User.find(params[:id])
      @user.banned = false
      @user.reviews.only_deleted.find_each(&:restore)
      Report.where(reportable: @user).destroy_all
      @user.save

      redirect_to :back
    end

  end
end
