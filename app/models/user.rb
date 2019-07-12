class User < ApplicationRecord
  validates :email, uniqueness: true, allow_nil: true
  validates :external_id, uniqueness: true, allow_nil: true
end
