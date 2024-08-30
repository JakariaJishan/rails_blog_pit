class SetNullToLikes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :likes, :post_id, true
    change_column_null :likes, :user_id, true
  end
end
