User.create!(
  name: 'kurita eiji',
  email: 'eiji199825@yahoo.co.jp',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

99.times do |n|
  name = Faker::Name.name
  email = "example#{n}@exmaple.com"
  password = 'password'
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    admin: false
  )
end