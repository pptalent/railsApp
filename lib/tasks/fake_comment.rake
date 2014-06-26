namespace :db do
  desc "create comment for micropost"
  task comment: :environment do
    microposts=Micropost.all
    3.times do
      content=Faker::Lorem.sentence(10)
      user_id=rand(10)+100
      microposts.each{|micropost| micropost.comments.create(content:content,user_id:user_id)}
    end
  end
end