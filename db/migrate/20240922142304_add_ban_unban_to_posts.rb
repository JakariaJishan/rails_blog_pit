class AddBanUnbanToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :banned, :boolean, default: false
  end
end
