class CreateActivities < ActiveRecord::Migration

  def change
    create_table :activities do |t|
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.belongs_to :plusone, index: true
    end
  end
end