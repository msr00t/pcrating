module Reviews
  class Converter

    def initialize(user)
      @user = user
      @old_ratings = user.ratings
      @changes = []
    end

    def convert_ratings_into_reviews
      @old_ratings.each do |old_rating|
        convert_rating_into_review(old_rating)
      end

      @changes.each do |change|
        puts change
      end

      return nil
    end

    private

      def convert_rating_into_review(old_rating)
        new_review = Review.new(user: @user,
                                review: old_rating.review,
                                game: old_rating.game)

        new_review = convert_framerate(new_review, old_rating)
        new_review = convert_optimization(new_review, old_rating)
        new_review = convert_mods(new_review, old_rating)
        new_review = convert_dlc(new_review, old_rating)
        new_review = convert_servers(new_review, old_rating)
        new_review = convert_bugs(new_review, old_rating)
        new_review = convert_resolution(new_review, old_rating)
        new_review = convert_settings(new_review, old_rating)
        new_review = convert_controls(new_review, old_rating)

        new_review.save

        old_rank = old_rating.ranking
        new_rank = new_review.rank

        if old_rank != new_rank
          @changes.push "ID: #{old_rating.id}\nOld rank: #{old_rank}\nNew rank: #{new_rank}\n"
        end

        new_review = convert_votes(new_review, old_rating)
      end

      def convert_framerate(new_review, old_rating)
        case old_rating[:framerate]
        when 0
          new_review.fps = '30 FPS Max'
        when 1, 2, 3
          new_review.fps = '60 FPS Max'
        when 4
          new_review.fps = 'Limitless'
        end

        new_review
      end

      def convert_resolution(new_review, old_rating)
        case old_rating[:resolution]
        when 0
          new_review.resolution = 'Does not support 1080p'
        when 1, 2
          new_review.resolution = 'Supports up to 1080p'
        when 3
          new_review.resolution = 'Supports up to 1080p'
          new_review.multi_monitor = 'Multi-monitor support'
        when 4
          new_review.resolution = '4k support'
        end

        new_review
      end

      def convert_optimization(new_review, old_rating)
        new_review.optimization = old_rating.optimization + " Optimization"
        new_review
      end

      def convert_mods(new_review, old_rating)
        case old_rating[:mods]
        when 0, 1
          new_review.cosmetic_modding = 'Cosmetic mods not supported'
          new_review.functionality_modding = 'Gameplay mods not supported'
          new_review.level_editors = 'No level editor'
          new_review.modding_tools = 'No modding tools provided'
        when 2
          new_review.functionality_modding = 'Gameplay mods not supported'
          new_review.level_editors = 'No level editor'
          new_review.modding_tools = 'No modding tools provided'
        when 3
          new_review.modding_tools = 'Modding tools available'
        when 4
          new_review.cosmetic_modding = 'Cosmetic mods supported'
          new_review.functionality_modding = 'Gameplay mods supported'
          new_review.modding_tools = 'Modding tools available'
        end

        new_review
      end

      def convert_servers(new_review, old_rating)
        case old_rating[:servers]
        when 0
          new_review.server_stability = "Servers down most of the time"
        when 1
          new_review.server_stability = "Servers unreliable"
        when 2
          new_review.server_stability = "Servers unstable at high volume"
        when 3
          new_review.server_stability = "Servers occasionally down"
        when 4
          new_review.server_stability = "Servers occasionally down"
        end

        new_review
      end

      def convert_dlc(new_review, old_rating)
        case old_rating[:dlc]
        when 0
          new_review.day_1_dlc = 'Day one DLC'
          new_review.dlc_quality = 'Effects game balance'
        when 1
          new_review.day_1_dlc = 'Day one DLC'
          new_review.dlc_quality = 'Cosmetic only'
        when 2
          new_review.day_1_dlc = 'No Day one DLC'
        when 3
          new_review.day_1_dlc = 'Day one DLC is free'
        when 4
          new_review.day_1_dlc = 'No Day one DLC'
          new_review.dlc_quality = 'Old style expansions'
        end

        new_review
      end

      def convert_bugs(new_review, old_rating)
        new_review.bugs = old_rating.bugs
        new_review
      end

      def convert_settings(new_review, old_rating)
        case old_rating[:settings]
        when 0
          new_review.video_options = 'Cannot change video settings'
        when 1
          new_review.video_options = 'Cannot change video settings'
        when 2
          new_review.video_options = 'Preset video settings only'
        when 3
          new_review.video_options = 'Can change most video settings'
        when 4
          new_review.video_options = 'Can change all video settings'
        end

        new_review
      end

      def convert_controls(new_review, old_rating)
        case old_rating[:controls]
        when 0
          new_review.key_remapping = 'Cannot remap keys'
        when 1
          new_review.key_remapping = 'Cannot remap keys'
        when 2
          new_review.key_remapping = 'Can remap keys'
          new_review.mouse_sensitivity_adjustment = 'Can adjust mouse sensitivity'
        when 3, 4
          new_review.key_remapping = 'Can remap keys'
          new_review.mouse_sensitivity_adjustment = 'Can adjust mouse sensitivity'
        end

        new_review
      end

      def convert_votes(new_review, old_rating)
        likers = old_rating.votes_for.up.voters
        dislikers = old_rating.votes_for.down.voters

        likers.each do |liker|
          new_review.liked_by liker
        end
        dislikers.each do |disliker|
          new_review.disliked_by disliker
        end
      end

  end
end