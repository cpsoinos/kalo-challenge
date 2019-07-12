class User < ApplicationRecord
  validates :email, uniqueness: true, allow_nil: true
  validates :external_id, uniqueness: true, allow_nil: true

  scope :global_admin, -> { where(global_admin: true) }
  scope :receive_marketing, -> { where(receive_marketing: true) }
  scope :by_timezone, ->(timezone) { where(timezone: timezone) }
  scope :with_skill, ->(skill) { where("users.skills::jsonb ? :skill", skill: skill) }
end
