class ModController < ApplicationController

  before_action :mod?

  private

    def mod?
      current_user && (current_user.mod? || current_user.admin?)
    end

end
