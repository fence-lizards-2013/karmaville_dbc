class User < ActiveRecord::Base
  has_many :karma_points

  attr_accessible :first_name, :last_name, :email, :username, :karma_points_count

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :username,
            :presence => true,
            :length => {:minimum => 2, :maximum => 32},
            :format => {:with => /^\w+$/},
            :uniqueness => {:case_sensitive => false}

  validates :email,
            :presence => true,
            :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
            :uniqueness => {:case_sensitive => false}

  def self.by_karma
    # joins(:karma_points).group('users.id').order('SUM(karma_points.value) DESC')
    order('karma_points_count DESC')
  end

  def total_karma
    # self.karma_points.sum(:value)
    self.karma_points_count
  end

  def increment_counter(value)
    counter = self.karma_points_count
    self.update_attributes(karma_points_count: counter + value)
  end

  def self.page(num)
    self.by_karma.limit(50).offset((num.to_i - 1)*50)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
