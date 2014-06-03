FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "Wayne_#{n}" }
    sequence(:email) { |n| "wayne_#{n}@sina.com" }
    password "1111"
    password_confirmation "1111"
  end
end