# The platform games can appear on. OS X, Windows, Linux.
class Platform < ActiveRecord::Base

  RANSACKABLE_ATTRIBUTES = %w(name)

  has_many :platform_games, dependent: :destroy
  has_many :games, through: :platform_games

  def self.ransackable_attributes(auth_object = nil)
    return super if auth_object == :admin
    super & RANSACKABLE_ATTRIBUTES
  end

end
