class Gift < ActiveRecord::Base
  belongs_to :user

  validates :user, :presence => true
  validates :name, :presence => true
  validates :url,  :presence => true

  def sell!(user)
    self.update_attributes(:purchased_by_user_id => user.id) unless self.user == user
  end

  def return!
    self.update_attributes(:purchased_by_user_id => nil)
  end

  def purchased?
    !self.purchased_by_user_id.nil?
  end

  def purchased_by?(user)
    self.purchased_by_user_id == user.id
  end

  def purchaser
    begin
      User.find(self.purchased_by_user_id)
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end
end
