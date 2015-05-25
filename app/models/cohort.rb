class Cohort < ActiveRecord::Base
  has_many :teams
  has_many :users, through: :enrollments
  has_many :enrollments

  def all_users_plusones_sorted_by_time(date)
    plusone_list = Plusone.where("p_date = '#{date}'").order(:created_at)
    plusone_list.delete_if {|plusone| !enrollments.exists?(user_id: plusone.user.id)}
  end

  def weekly_best(week)
    User.find_by(username: all_users_weely_scores(week).sort{|a,b| b[1]<=>a[1]}[0][0])
  end

  def weekly_worst(week)
    User.find_by(username: all_users_weely_scores(week).sort{|a,b| a[1]<=>b[1]}[0][0])
  end

  def all_users_weely_scores(week)
    scores = Hash.new(0)
    users.each {|user| 
      name = user.username
      scores.store(name , user.weekly_total_score(week))}
    scores
  end
end