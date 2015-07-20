class Publisher < ActiveRecord::Base

  has_many :publisher_games, dependent: :destroy
  has_many :games, through: :publisher_games

  private

    def self.ransackable_attributes(auth_object = nil)
      if auth_object == :admin
        super
      else
        super & %w(name)
      end
    end

end
