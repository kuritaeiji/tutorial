# User.create!(
#   name: 'kurita eiji',
#   email: 'eiji199825@yahoo.co.jp',
#   password: 'password',
#   password_confirmation: 'password',
#   admin: true
# )

# 99.times do |n|
#   name = Faker::Name.name
#   email = "example#{n}@exmaple.com"
#   password = 'password'
#   User.create!(
#     name: name,
#     email: email,
#     password: password,
#     password_confirmation: password,
#     admin: false
#   )
# end

# users = User.all.order(created_at: :asc).take(6)
# users.each do |user|
#   50.times do
#     content = Faker::Lorem.sentence(5)
#     user.microposts.create!(content: content)
#   end
# end

users = User.all
user = User.first
followings = users[2..50]
followers = users[3..40]
followings.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }