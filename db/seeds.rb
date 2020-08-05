require 'faker'

users = []
10.times { users << User.create!(username: Faker::Name.first_name) }

categories = { football: "football", basketball: "basketball", rock_music: "rock_music" }
categories_id = {}
categories.each_pair { |key, value| categories_id[key] = Category.create!(title: value).id }

football_tests = []
basketball_tests = []
rock_music_tests = []

10.times { football_tests << Test.create!(title: Faker::Sports::Football.player, level: rand(0..2),
  category_id: categories_id[:football]) }

10.times { basketball_tests << Test.create!(title: Faker::Sports::Basketball.team, level: rand(0..2),
  category_id: categories_id[:basketball]) }

10.times { rock_music_tests << Test.create!(title: Faker::Music::RockBand.name, level: rand(0..2),
  category_id: categories_id[:rock_music]) }
