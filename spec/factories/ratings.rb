require 'faker'

FactoryGirl.define do
  factory :rating do
    framerate     { (0..4).to_a.sample }
    resolution    { (0..4).to_a.sample }
    optimization  { (0..4).to_a.sample }
    dlc           { (0..4).to_a.sample }
    bugs          { (0..4).to_a.sample }
    settings      { (0..4).to_a.sample }
    controls      { (0..4).to_a.sample }
    servers       { (0..4).to_a.sample }
    mods          { (0..4).to_a.sample }

    trait :p do
      framerate 0
      resolution 0
      optimization 0
      dlc 0
      bugs 0
      settings 0
      controls 0
      servers 0
      mods 0
    end

    trait :c do
      framerate 1
      resolution 1
      optimization 1
      dlc 1
      bugs 1
      settings 1
      controls 1
      servers 1
      mods 1
    end

    trait :m do
      framerate 2
      resolution 2
      optimization 2
      dlc 2
      bugs 2
      settings 2
      controls 2
      servers 2
      mods 2
    end

    trait :r do
      framerate 3
      resolution 3
      optimization 3
      dlc 3
      bugs 3
      settings 3
      controls 3
      servers 3
      mods 3
    end

    trait :g do
      framerate 4
      resolution 4
      optimization 4
      dlc 4
      bugs 4
      settings 4
      controls 4
      servers 4
      mods 4
    end

  end
end
