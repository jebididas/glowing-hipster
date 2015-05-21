class Plusone < ActiveRecord::Base
  belongs_to :users

  validates :score, presence: true,
                    numericality: { only_integer: true, greater_than: -51, less_than: 51 }
end