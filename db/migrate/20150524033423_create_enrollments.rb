class CreateEnrollments < ActiveRecord::Migration
  def change 
    create_table :enrollments do |t|
      t.integer :user_id, index: true
      t.integer :cohort_id, index: true
      t.datetime :enrollment_date
    end
  end
end