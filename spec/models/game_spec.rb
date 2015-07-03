require 'spec_helper'

describe Game do

  before do
    VCR.use_cassette('steam_api_hit') do
      @game = create(:game)
      @user = create(:user)
      @url = "http://store.steampowered.com/api/appdetails/?appids=#{@game.steam_appid}"
      resp = Net::HTTP.get_response(URI.parse(@url))
      @data = JSON.parse(resp.body)
    end
  end

  subject { @game }

  it { should respond_to(:steam_appid) }
  it { should respond_to(:data) }
  it { should respond_to(:title) }
  it { should respond_to(:slug) }

  it { should have_many(:users) }
  it { should have_many(:ratings) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:steam_appid) }
  it { should validate_uniqueness_of(:steam_appid) }

  it 'has a valid factory' do
    expect(@game).to be_valid
  end

  describe '.description' do
    it 'should return the game description' do
      expect(@game.description).to be_a String
    end

    it 'should return the value returned the the steam api response' do
      desc = @data[@data.keys[0]]['data']['detailed_description']
      expect(@game.description).to eq desc
    end
  end

  describe '.dlc' do
    it "should return an array of a game's DLC" do
      expect(@game.dlc).to be_an Array
    end

    it 'should return the value returned the the steam api response' do
      expect(@game.dlc).to eq @data[@data.keys[0]]['data']['dlc']
    end
  end

  describe '.min_requirements' do
    it 'should return a string' do
      expect(@game.min_requirements).to be_a String
    end

    it 'should return the value returned the the steam api response' do
      min = @data[@data.keys[0]]['data']['pc_requirements']['minimum']
      expect(@game.min_requirements).to eq min
    end
  end

  describe '.recommended_requirements' do
    it 'should return a string' do
      expect(@game.recommended_requirements).to be_a String
    end

    it 'should return the value returned the the steam api response' do
      rec = @data[@data.keys[0]]['data']['pc_requirements']['recommended']
      expect(@game.recommended_requirements).to eq rec
    end
  end

  describe '.developers' do
    it 'should return an array' do
      expect(@game.developers).to be_an Array
    end

    it 'should return the value returned the the steam api response' do
      expect(@game.developers).to eq @data[@data.keys[0]]['data']['developers']
    end
  end

  describe '.publishers' do
    it 'should return an array' do
      expect(@game.publishers).to be_an Array
    end

    it 'should return the value returned the the steam api response' do
      expect(@game.publishers).to eq @data[@data.keys[0]]['data']['publishers']
    end
  end

  describe '.header_image' do
    it 'should return a url' do
      expect(uri?(@game.header_image)).to eq true
    end

    it 'should return the value returned the the steam api response' do
      image = @data[@data.keys[0]]['data']['header_image']
      expect(@game.header_image).to eq image
    end
  end

  describe '.website' do
    it 'should return a url' do
      expect(uri?(@game.website)).to eq true
    end

    it 'should return the value returned the the steam api response' do
      expect(@game.website).to eq @data[@data.keys[0]]['data']['website']
    end
  end

  describe '.launch_game_link' do
    it 'returns a link that loads a game via the steam protocol' do
      expect(@game.launch_game_link).to eq "steam://run/#{@game.steam_appid}"
    end
  end

  describe '.rated_by_user?' do
    describe 'when the user has rated the game' do
      before do
        create(:rating, user: @user, game: @game)
      end

      it 'returns true' do
        expect(@game.rated_by_user?(@user)).to eq true
      end
    end

    describe 'when the user has not rated the game' do
      it 'returns true' do
        expect(@game.rated_by_user?(@user)).to eq false
      end
    end
  end

  describe '.rating' do
    describe 'with no ratings' do
      it 'returns false' do
        expect(@game.rating).to eq false
      end
    end

    describe 'with one rating' do
      before do
        @rating = create(:rating, game: @game, user: @user)
      end

      it 'returns the same rating as that rating' do
        expect(@game.rating).to eq @rating.total
      end
    end

    describe 'with multiple ratings' do
      before do
        rating_1 = create(:rating, game: @game, user: create(:user))
        rating_2 = create(:rating, game: @game, user: create(:user))
        rating_3 = create(:rating, game: @game, user: create(:user))
        total = rating_1.total + rating_2.total + rating_3.total
        @average = total / 3
      end

      it 'returns the average of those ratings' do
        expect(@game.rating).to eq @average
      end
    end

    describe 'with hidden reviews' do
      before do
        @rating_visible = create(:rating, :p, game: @game, user: create(:user))
        rating_hidden = create(:rating, :g, game: @game, user: create(:user))

        rating_hidden.downvote_from create(:user)
        rating_hidden.downvote_from create(:user)
        rating_hidden.downvote_from create(:user)
        rating_hidden.downvote_from create(:user)
        rating_hidden.downvote_from create(:user)
      end

      it 'does not include hidden reviews in the rating' do
        expect(@game.rating).to eq @rating_visible.total
      end
    end
  end

  describe '.ranking' do
    before do
      create(:rating, game: @game, user: create(:user))
    end

    it 'returns the correct ranking' do
      expect(@game.ranking).to eq Rating.ranking(@game.rating)
    end

    describe 'with ratings that equal a p ranking' do
      before do
        Rating.destroy_all
        create(:rating, :p, game: @game, user: create(:user))
      end

      it 'returns :p' do
        expect(@game.ranking).to eq :p
      end
    end

    describe 'with ratings that equal a c ranking' do
      before do
        Rating.destroy_all
        create(:rating, :c, game: @game, user: create(:user))
      end

      it 'returns :c' do
        expect(@game.ranking).to eq :c
      end
    end

    describe 'with ratings that equal a m ranking' do
      before do
        Rating.destroy_all
        create(:rating, :m, game: @game, user: create(:user))
      end

      it 'returns :m' do
        expect(@game.ranking).to eq :m
      end
    end

    describe 'with ratings that average to a m ranking' do
      before do
        Rating.destroy_all
        create(:rating, :g, game: @game, user: create(:user))
        create(:rating, :p, game: @game, user: create(:user))
      end

      it 'returns :m' do
        expect(@game.ranking).to eq :m
      end
    end

    describe 'with ratings that equal a r ranking' do
      before do
        Rating.destroy_all
        create(:rating, :r, game: @game, user: create(:user))
      end

      it 'returns :r' do
        expect(@game.ranking).to eq :r
      end
    end

    describe 'with ratings that equal a g ranking' do
      before do
        Rating.destroy_all
        create(:rating, :g, game: @game, user: create(:user))
      end

      it 'returns :g' do
        expect(@game.ranking).to eq :g
      end
    end
  end

  describe '.get_stat_string' do
    [
      :framerate, :resolution, :optimization, :mods,
      :servers, :dlc, :bugs, :settings, :controls
    ].each do |stat|
      describe "(#{stat})" do
        describe 'with no ratings' do
          it 'returns N/A' do
            expect(@game.get_stat_string(stat)).to eq 'N/A'
          end
        end

        describe 'with one ratings' do
          before do
            @rating = create(:rating, game: @game, user: create(:user))
          end

          it "returns the string matching the game's rating" do
            expect(@game.get_stat_string(stat)).to eq @rating.send(stat)
          end
        end

        describe 'with multiple ratings' do
          before do
            create(:rating, game: @game, user: create(:user))
            create(:rating, game: @game, user: create(:user))
            create(:rating, game: @game, user: create(:user))
          end

          it "returns the string matching the game's rating" do
            expected_rating = Rating.send(stat.to_s.pluralize.to_sym).to_a[@game.get_stat(stat)][0]
            expect(@game.get_stat_string(stat)).to eq expected_rating
          end
        end
      end
    end
  end

  describe '.get_stat' do
    [
      :framerate, :resolution, :optimization, :mods,
      :servers, :dlc, :bugs, :settings, :controls
    ].each do |stat|
      describe "(#{stat})" do
        describe 'with no ratings' do
          it 'returns N/A' do
            expect(@game.get_stat(stat)).to eq false
          end
        end

        describe 'with one ratings' do
          before do
            @rating = create(:rating, game: @game, user: create(:user))
          end

          it "returns the string matching the game's rating" do
            expect(@game.get_stat(stat)).to eq @rating[stat]
          end
        end

        describe 'with multiple ratings' do
          before do
            rating_1 = create(:rating, game: @game, user: create(:user))
            rating_2 = create(:rating, game: @game, user: create(:user))
            rating_3 = create(:rating, game: @game, user: create(:user))
            ratings_total = rating_1[stat] + rating_2[stat] + rating_3[stat]
            @expected_rating = ratings_total / 3.0
          end

          it "returns the string matching the game's rating" do
            expect(@game.get_stat(stat)).to eq @expected_rating
          end
        end
      end
    end
  end

  describe '.get_rounded_stat' do
    [
      :framerate, :resolution, :optimization, :mods,
      :servers, :dlc, :bugs, :settings, :controls
    ].each do |stat|
      describe "(#{stat})" do
        describe 'with no ratings' do
          it 'returns N/A' do
            expect(@game.get_rounded_stat(stat)).to eq false
          end
        end

        describe 'with one ratings' do
          before do
            @rating = create(:rating, game: @game, user: create(:user))
          end

          it "returns the string matching the game's rating" do
            expect(@game.get_rounded_stat(stat)).to eq @rating[stat].round
          end
        end

        describe 'with multiple ratings' do
          before do
            rating_1 = create(:rating, game: @game, user: create(:user))
            rating_2 = create(:rating, game: @game, user: create(:user))
            rating_3 = create(:rating, game: @game, user: create(:user))
            ratings_total = rating_1[stat] + rating_2[stat] + rating_3[stat]
            @expected_rating = ratings_total / 3.0
          end

          it "returns the string matching the game's rating" do
            expect(@game.get_rounded_stat(stat)).to eq @expected_rating.round
          end
        end
      end
    end
  end

end
