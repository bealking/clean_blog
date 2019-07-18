class AddFollowsCountToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :follows_count, :integer, default: 0, null: false
  end
end
