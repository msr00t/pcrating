require 'spec_helper'

describe Game do

  before do
    VCR.use_cassette('steam_api_hit') do
      @game = create(:game)
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
    it 'should return the games description' do
      expect(@game.description).to be_a String
    end
  end
  describe '.dlc' do
    it "should return an array of a game's DLC" do
      expect(@game.dlc).to be_an Array
    end
  end
  describe '.min_requirements' do
    it 'should return a string' do
      expect(@game.min_requirements).to be_a String
    end
  end
  describe '.recommended_requirements' do
    it 'should return a string' do
      expect(@game.recommended_requirements).to be_a String
    end
  end
  describe '.developers' do
    it 'should return an array' do
      expect(@game.developers).to be_an Array
    end
  end
  describe '.publishers' do
    it 'should return an array' do
      expect(@game.publishers).to be_an Array
    end
  end
  describe '.header_image' do
    it 'should return a url' do
      expect(uri?(@game.header_image)).to eq true
    end
  end
  describe '.website' do
    it 'should return a url' do
      expect(uri?(@game.website)).to eq true
    end
  end
  describe '.launch_game_link' do
    it 'returns a link that loads a game via the steam protocol' do
      expect(@game.launch_game_link).to eq "steam://run/#{@game.steam_appid}"
    end
  end

end
