class AdminController < ApplicationController

  before_action :admin?

  private

    def admin?
      current_user && current_user.admin?
    end

end
