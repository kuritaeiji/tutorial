class Micropost < ApplicationRecord
  belongs_to(:user)
  has_one(:image, as: :imageable)
  include(Imageable)

  validates(:content, presence: true, length: { maximum: 140 })
  default_scope(-> { order(created_at: :desc) })
end
