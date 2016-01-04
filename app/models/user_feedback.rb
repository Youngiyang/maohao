class UserFeedback < ActiveRecord::Base
  validates :content, presence: true, length: 5..200
end
