class AddPlusonesDescription < ActiveRecord::Migration
  def change
    add_column :plusones, :description, :string
  end
end
