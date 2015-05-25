class Cohort < ActiveRecord::Base
  has_many :teams
  has_many :users, through: :enrollments
  has_many :enrollments

  def all_users_plusones_sorted_by_time(date)
    # User.select('plusone.description').order(:created_at).(:plusone)
    # Plusone.joins(:user).where("p_date = '#{date}'").group('users.username').order(:created_at)
    Plusone.where("p_date = '#{date}'").order(:created_at)

    # sorted_user_list = Array.new(0)
    # users.each {|user|
    #   sorted_user_list.push(user.plusones.where("p_date = '#{date}'"))
    # }
    # users.joins("LEFT JOIN plusones").where("plusones.p_date = '#{date}'")
    # Cohort.joins(:articles).where(articles: { author: author })

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

  # def all_users_sorted_by_score(week)
  #   sorted_user_list = Array.new(0)
  #   all_users_weely_scores(week).sort{|a,b| b[1]<=>a[1]}.each { |score| sorted_user_list.push(score[0])}
  # end
end