class User < ActiveRecord::Base
  has_secure_password
  has_many :gifts

  validates :name,  :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => { :on => :create }
end
