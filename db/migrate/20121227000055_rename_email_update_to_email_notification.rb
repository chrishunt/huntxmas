class RenameEmailUpdateToEmailNotification < ActiveRecord::Migration
  def change
    rename_column :users, :email_updates, :email_notifications
  end
end
