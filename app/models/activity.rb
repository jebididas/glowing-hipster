class Activity < ActiveRecord::Base
  validates :description, presence:  true
end