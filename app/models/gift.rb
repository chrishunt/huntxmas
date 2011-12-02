class Gift < ActiveRecord::Base
  belongs_to :user

  validates :user, :presence => true
  validates :name, :presence => true
  validates :url,  :presence => true

  def purchased?
    !self.purchased_by_user_id.nil?
  end
end
