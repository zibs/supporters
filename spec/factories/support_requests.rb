FactoryGirl.define do
  factory :support_request do
    sequence(:name) { |n| "#{Faker::Name.name}-#{n}" }
    sequence(:email) {|n| "#{Faker::Internet.email}" }
    department          { ( Random.rand(3)) }
    message      { Faker::Hacker.say_something_smart }
    complete false
  end
end
