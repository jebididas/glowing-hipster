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
    Plusone.where("p_date = '#{date}'").order(:created_at)
  end

  def daily_total_score(date)
    Plusone.where("p_date = '#{date}'").inject(0){ |sum, p| sum + p.score }
  end

  def plusones_of_week(week)
    wkBegin = Date.commercial(2015, week, 1)
    wkEnd = Date.commercial(2015, week, 7)
    Plusone.where(:p_date => wkBegin..wkEnd.end_of_day)
  end

  def week_scores(week)
    week_scores = Array.new(0)
    week_dates = Array.new(0)
    plusones = plusones_of_week(week)
    
    plusones.each { |plusone|
      week_dates.push(plusone.p_date).uniq!
    }
    week_dates.each { |date|
      week_scores.push(daily_total_score(date))
    }
    week_scores
  end

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