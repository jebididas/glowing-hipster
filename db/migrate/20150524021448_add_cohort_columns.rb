class AddCohortColumns < ActiveRecord::Migration
  def change
    add_column :cohorts, :admin, :integer
    add_column :cohorts, :created_at, :datetime
    add_column :cohorts, :updated_at, :datetime
    add_column :cohorts, :password, :string
  end
end
