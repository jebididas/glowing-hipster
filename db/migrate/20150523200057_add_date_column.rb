class AddDateColumn < ActiveRecord::Migration
  def change
    add_column :plusones, :date, :date
  end
end
