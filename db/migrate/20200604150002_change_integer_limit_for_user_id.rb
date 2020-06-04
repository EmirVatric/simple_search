class ChangeIntegerLimitForUserId < ActiveRecord::Migration[6.0]
  def change
    change_column :queries, :user_id, :integer, limit: 8
  end
end
