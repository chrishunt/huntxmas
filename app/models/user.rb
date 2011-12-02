class User < ActiveRecord::Base
  has_secure_password
  has_many :gifts

  validates :name,  :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => { :on => :create }

  def purchase(gift)
    gift.update_attributes(:purchased_by_user_id => self.id) unless gift.user == self
  end
end
