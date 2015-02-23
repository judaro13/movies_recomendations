class Movie < ActiveRecord::Base
  has_many :ratings
  #id: imdb id
  #name
  #image_url: poster url
  #genders: string
  
  attr_accessible :id, :name, :image_url, :genders
end
