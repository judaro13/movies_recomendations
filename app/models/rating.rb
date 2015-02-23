class Rating < ActiveRecord::Base
  belongs_to :user, :foreign_key => :user_id
  belongs_to :movie, :foreign_key => :movie_id
  #id
  #user_id
  #movie_id
  #value -> rating
  #count -> total voted
  attr_accessible :id, :user_id, :movie_id, :value, :count
end
