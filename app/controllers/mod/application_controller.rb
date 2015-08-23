module Mod
  # Mod Application Controller
  # Superclass for all the Mod level actions. Prevents anyone with an admin
  # level below 1 from calling these actions.
  class ApplicationController < ApplicationController

    before_action :mod?

    layout 'mod'

    private

    def mod?
      redirect_to root_path unless current_user && current_user.moderator?
    end

  end
end
