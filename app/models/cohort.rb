class Cohort < ActiveRecord::Base
  has_many :teams
  has_and_belongs_to_many :users
end