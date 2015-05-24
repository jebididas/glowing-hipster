class Activity < ActiveRecord::Base
  has_one :plusone
  validates :description, presence: true
end