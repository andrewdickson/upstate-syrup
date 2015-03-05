class Review < ActiveRecord::Base
  acts_as_list

  attr_accessible :comment, :name, :rating, :position
end
