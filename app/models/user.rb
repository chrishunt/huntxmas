class User < ActiveRecord::Base
  has_secure_password
  has_many :gifts

  validates :name,  :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => { :on => :create }

  def purchase(gift)
    gift.sell!(self)
  end

  def return(gift)
    purchased_by = gift.purchased_by?(self)
    gift.return! if purchased_by
    return purchased_by
  end
end
