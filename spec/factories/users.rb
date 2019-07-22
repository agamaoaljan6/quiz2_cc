FactoryBot.define do
  factory :user do
    sequence(:username) {Faker::Name.last_name }
    sequence(:email) {|n| "#{n}-#{ Faker::Internet.email}"}
    password { "supersecret" }
  end
end
