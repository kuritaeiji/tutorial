FactoryBot.define do
  factory :user do
    name { 'test-user' }
    sequence(:email) { |i| "test#{i}@test.com" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
    activated { true }
  end

  trait(:not_admin) do
    admin { false }
  end

  trait(:not_activated) do
    activated { false }
  end
end
