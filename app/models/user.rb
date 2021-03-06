class User < ActiveRecord::Base
  has_many :ratings
  #id: 
  #name
  #image_url
  #nick: twitter nick
#   attr_accessible :id, :name, :image_url, :handle
  
  validates_uniqueness_of :id, :nick
  
  
  def voted_movies
    c = []
    self.ratings.where(predict: false).each{|r| c << r.movie_id}
    Movie.where(id: c)
  end
end
