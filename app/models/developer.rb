class Developer < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  RANSACKABLE_ATTRIBUTES = %w(name)

  has_many :developer_games, dependent: :destroy
  has_many :games, through: :developer_games

  private

    def self.ransackable_attributes(auth_object = nil)
      return super if auth_object == :admin
      super & RANSACKABLE_ATTRIBUTES
    end

end
