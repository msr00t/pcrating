class Platform < ActiveRecord::Base

  has_many :platform_games, dependent: :destroy
  has_many :games, through: :platform_games

  private

    def self.ransackable_attributes(auth_object = nil)
      if auth_object == :admin
        # whitelist all attributes for admin
        super
      else
        # whitelist only the title and body attributes for other users
        super & %w(name)
      end
    end

end
