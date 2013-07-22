class AddKarmaCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :karma_points_count, :integer
    add_index :karma_points, :user_id
  end
end
