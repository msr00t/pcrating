# Admin Application Controller
# Superclass for all the Admin level actions. Prevents anyone with an admin
# level below 2 from calling these actions.
class Admin::ApplicationController < ApplicationController

  before_action :admin?

  layout 'mod'

  private

  def admin?
    redirect_to root_path unless current_user && current_user.admin?
  end

end