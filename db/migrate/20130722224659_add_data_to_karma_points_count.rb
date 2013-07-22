class AddDataToKarmaPointsCount < ActiveRecord::Migration
  def change
    User.find_each do |u|
      u.update_attribute(:karma_points_count, u.karma_points.sum(:value))
      p u.id
    end
  end
end
