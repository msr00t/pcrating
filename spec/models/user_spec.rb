require 'spec_helper'

describe User do
  before { @user = build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:username) }
  it { should respond_to(:admin?) }
  it { should respond_to(:banned?) }

  it { should have_many(:ratings) }
  it { should have_many(:games) }
  it { should have_many(:added_games) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end
end
