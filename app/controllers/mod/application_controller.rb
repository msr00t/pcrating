class Mod::ApplicationController < ApplicationController

  before_action :mod?

  layout 'mod'

  private

    def mod?
      redirect_to root_path unless current_user && current_user.moderator?
    end

end
