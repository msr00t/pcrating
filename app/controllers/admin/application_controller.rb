class Admin::ApplicationController < ApplicationController

  before_action :admin?

  layout 'mod'

  private

    def admin?
      redirect_to root_path unless current_user && current_user.admin?
    end

end
