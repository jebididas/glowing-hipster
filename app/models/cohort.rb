class Cohort < ActiveRecord::Base
  has_many :teams
  has_many :users, through: :enrollments
  has_many :enrollments
end