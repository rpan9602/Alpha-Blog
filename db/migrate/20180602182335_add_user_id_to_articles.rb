class AddUserIdToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :user_id, :integer	# last :integer is foreign key
  end
end
