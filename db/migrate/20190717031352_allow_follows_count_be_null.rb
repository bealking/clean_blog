class AllowFollowsCountBeNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :posts, :follows_count, true
    change_column_null :articles, :follows_count, true
  end
end
