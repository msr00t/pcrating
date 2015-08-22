class DeveloperGame < ActiveRecord::Base

  belongs_to :game
  belongs_to :developer

  validates_uniqueness_of :game_id, scope: :developer_id

end
