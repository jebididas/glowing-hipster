class User < ActiveRecord::Base
  has_many :plusones
  has_many :cohorts, through: :enrollments
  has_many :enrollments
  
  validates :username, :email, 
            presence: true, 
            uniqueness: true
  validates :password, 
            presence: true

  def total_score
    plusones.inject(0){ |sum, p| sum + p.score }
  end

  def plusones_sorted_by_time(date)
    plusones.where("p_date = '#{date}'").order(:created_at)
  end

  def daily_total_score(date)
    # plusones.where("p_date = '#{date}'").inject(0){ |sum, p| sum + p.score }
    plusones.where("p_date = '#{date}'").sum(:score)
  end

  # def plusones_of_week(week)
  #   wkBegin = Date.commercial(2015, week, 1)
  #   wkEnd = Date.commercial(2015, week, 7)
  #   plusones.where(:p_date => wkBegin..wkEnd.end_of_day)
  # end

  def week_scores(week)
    dates_of_week = Array.new(0)
    scores_of_week = Array.new(0)
    for day in 1..7 do dates_of_week.push(Date.commercial(2015, week, day)) end
    dates_of_week.each {|date|
      # score = (daily_total_score(date)==0) ? 0 : daily_total_score(date)
      scores_of_week.push(daily_total_score(date)) 
    }
    scores_of_week
  end

  # def plusones_of_week_grouped_by_date(week)
  #   wkBegin = Date.commercial(2015, week, 1)
  #   wkEnd = Date.commercial(2015, week, 7)
  #   for day 0..6 {
  #     temp = [Date.commercial(2015, week, day + 1), plusones_of_week(week)]


  #   plusones_of_week(week)
  # end

  # def week_scores(week)
  #   week_scores = Array.new(0)
  #   week_dates = Array.new(0)
  #   plusones = plusones_of_week(week)
    
  #   plusones.each { |plusone|
  #     week_dates.push(plusone.p_date).uniq!
  #   }
  #   week_dates.each { |date|
  #     week_scores.push(daily_total_score(date))
  #   }
  #   week_scores
  # end

  def weekly_total_score(week)
    week_scores(week).inject(0){ |sum, p| sum + p }
  end

  def week_dates(week)
    week_dates = Array.new(0)
    plusones_of_week(week).each {|plusone|
      week_dates.push(plusone.p_date).uniq!
    }
    week_dates
  end

end