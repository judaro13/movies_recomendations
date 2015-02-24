class Movie < ActiveRecord::Base
  has_many :ratings
  #id: imdb id
  #name
  #image_url: poster url
  #genders: string
  
#   attr_accessor :id, :name, :image_url, :genders
end
