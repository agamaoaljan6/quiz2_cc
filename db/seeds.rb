
Review.delete_all
Idea.delete_all
User.delete_all

10.times do
    User.create(
        username: Faker::Name.unique.name,
        email: "#{Faker::Name.unique.name}@example.com",
        password: 'supersecret'
    )
end

users = User.all

50.times do
    created_at = Faker::Date.backward(365 * 5)
    i = Idea.create(
        title: Faker::Nation.capital_city,
        description: Faker::Lorem.paragraph(2),
        user: users.sample
    )
    if i.valid?
        i.reviews = rand(0..15).times.map do
            Review.new(
                body: Faker::Hipster.sentence,
                user: users.sample
            )
        end
    end
end

ideas = Idea.all
reviews = Review.all

puts Cowsay.say("Generated #{ ideas.count } ideas", :cow)
puts Cowsay.say("Generated #{ reviews.count } reviews", :stegosaurus)
puts Cowsay.say("Generated #{ users.count } users", :sheep)