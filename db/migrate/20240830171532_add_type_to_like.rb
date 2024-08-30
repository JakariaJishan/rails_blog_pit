class AddTypeToLike < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :likes_type, :string
  end
end
