class AddTimestampsToTables < ActiveRecord::Migration
  def change
    add_column(:games, :created_at, :datetime)
    add_column(:games, :updated_at, :datetime)

    Game.all.each do |game|
      game.created_at = Time.now
      game.updated_at = Time.now
      game.save
    end
  end
end
