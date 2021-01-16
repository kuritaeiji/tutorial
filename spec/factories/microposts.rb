FactoryBot.define do
  factory :micropost do
    association(:user)
    content { 'test content' }
    created_at { Time.zone.now }
  end
end
