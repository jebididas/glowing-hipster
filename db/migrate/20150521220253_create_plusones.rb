class CreatePlusones < ActiveRecord::Migration
  def up
    create_table :plusones do |t|
      t.integer :score
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :user_id, references: :users      
    end
  end
  def down
    drop_table :plusones
  end
end
