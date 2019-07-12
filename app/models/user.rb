class User < ApplicationRecord
  include Filterable
  include PgSearch

  pg_search_scope :search, against: [:email, :name, :timezone, :external_id, :skills]

  validates :email, uniqueness: true, allow_nil: true
  validates :external_id, uniqueness: true, allow_nil: true
  validates :name, presence: true

  scope :global_admin, -> { where(global_admin: true) }
  scope :receive_marketing, -> { where(receive_marketing: true) }
  scope :by_global_admin, ->(is_admin) { where(global_admin: ActiveModel::Type::Boolean.new.cast(is_admin)) }
  scope :by_receive_marketing, ->(opt_in) { where(receive_marketing: ActiveModel::Type::Boolean.new.cast(opt_in)) }
  scope :by_timezone, ->(timezone) { where(timezone: timezone) }
  scope :with_skill, ->(skill) { where("users.skills::jsonb ? :skill", skill: skill) }
end
