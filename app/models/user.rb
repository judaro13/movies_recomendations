class User < ActiveRecord::Base
  has_many :ratings
  #id: twitter id
  #name
  #image_url
  #handle: twitter id
  attr_accessible :id, :name, :image_url, :handle
  
end
