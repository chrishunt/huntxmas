class AddPurchasedByUserIdToGift < ActiveRecord::Migration
  def change
    add_column :gifts, :purchased_by_user_id, :integer
  end
end
