namespace :db do
  desc "create fake user"
    task populate: :environment do
      99.times do |n|
        name=Faker::Name.name
        email="superxiao-#{n}@163.com"
        password="wangzixiao"
        User.create!(name:name,email:email,password:password,password_confirmation:password)
      end
    end
end