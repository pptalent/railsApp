namespace :db do
  desc "create sample microposts"
  task microposts: :environment do
    user=User.find(5);
    50.times do
      content=Faker::Lorem.sentence(5)
      user.microposts.create!(content:content);
    end
  end
end