namespace :db do
  desc "create micropost for first five user"
  task micropost: :environment do
    users=User.all(limit:5)
    5.times do
      content=Faker::Lorem.sentence(5)
      users.each{|user| user.microposts.create(content:content)}
    end
  end
end