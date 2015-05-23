class AddDateColumn < ActiveRecord::Migration
  def change
    add_column :plusones, :p_date, :date
  end
end
