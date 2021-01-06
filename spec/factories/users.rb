FactoryBot.define do
  factory :user do
    name { 'test-user' }
    sequence(:email) { |i| "test#{i}@test.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
