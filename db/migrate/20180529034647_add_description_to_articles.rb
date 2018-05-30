class AddDescriptionToArticles < ActiveRecord::Migration[5.2]
  def change
    # we added attributes below manually after cmd :
    # >> rails generate migration add_description_to_articles
    add_column :articles, :description, :text
    add_column :articles, :created_at, :datetime	## 'create_at' attribute is maintained by Rails.
    add_column :articles, :updated_at, :datetime    ## 'update_at' attribute is maintained by Rails.
  end
end
