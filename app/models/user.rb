class User < ActiveRecord::Base
  has_many :plusones
  
  validates :username, :email, 
            presence: true, 
            uniqueness: true
  validates :password, 
            presence: true

  def total_score
    plusones.inject(0){ |sum, p| sum + p.score }
  end

  def plusones_sorted_by_time(date)
    Plusone.where("p_date = '#{date}'").order(:created_at)
end


end