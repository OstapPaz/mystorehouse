class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # scope :by_user, ->(user) { where(user_id: user.id) }
end
