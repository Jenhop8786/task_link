class User < ActiveRecord::Base
  has_many :lists
  has_many :tasks, through: :lists

  has_secure_password
  validates_presence_of :username, :password 
end#class
