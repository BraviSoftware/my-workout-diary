class ActivityType < ActiveRecord::Base
  has_many :activity
  default_scope { where(status: true) }
end
