FactoryBot.define do
  factory :idea do
    title { Faker::Name.unique.name }
    description { Faker::Lorem.paragraph(2) }
    association(:user, factory: :user)
  end
end
