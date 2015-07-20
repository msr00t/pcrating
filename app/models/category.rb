class Category < ActiveRecord::Base

  RANSACKABLE_ATTRIBUTES = %w(name)

  has_many :category_games, dependent: :destroy
  has_many :games, through: :category_games

  private

    def self.ransackable_attributes(auth_object = nil)
      return super if auth_object == :admin
      super & RANSACKABLE_ATTRIBUTES
    end

end
