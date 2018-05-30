# rails generate migration create_articles: generated this file
class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title	# we add this manually.
    end
  end
end
