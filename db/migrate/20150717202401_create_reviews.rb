class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|

      t.integer :fps
      t.integer :resolution
      t.integer :multi_monitor

      t.integer :optimization
      t.integer :bugs

      t.integer :cosmetic_modding
      t.integer :functionality_modding
      t.integer :modding_tools
      t.integer :level_editors

      t.integer :server_stability
      t.integer :dedicated_servers
      t.integer :multiplayer_servers_turned_off
      t.integer :lan_support

      t.integer :day_1_dlc
      t.integer :dlc_quality

      t.integer :video_options
      t.integer :controller_support
      t.integer :key_remapping
      t.integer :mouse_sensitivity_adjustment
      t.integer :vr_support

      t.integer :subtitle_support

      t.integer :launcher_drm
      t.integer :limited_activations
      t.integer :drm_free
      t.integer :disc_check
      t.integer :always_on_drm
      t.integer :drm_servers_off

      t.integer :opinion

      t.string :review

      t.integer :user_id, null: false
      t.integer :game_id, null: false

      t.timestamps null: false

      t.integer :reviews, :cached_votes_total, default: 0
      t.integer :reviews, :cached_votes_score, default: 0
      t.integer :reviews, :cached_votes_up, default: 0
      t.integer :reviews, :cached_votes_down, default: 0
      t.integer :reviews, :cached_weighted_score, default: 0
      t.integer :reviews, :cached_weighted_total, default: 0
      t.float :reviews, :cached_weighted_average, default: 0.0

      t.float :reviews, :cached_rank
      t.float :reviews, :cached_score

    end

    add_index :reviews, :cached_votes_total
    add_index :reviews, :cached_votes_score
    add_index :reviews, :cached_votes_up
    add_index :reviews, :cached_votes_down
    add_index :reviews, :cached_weighted_score
    add_index :reviews, :cached_weighted_total
    add_index :reviews, :cached_weighted_average
  end
end