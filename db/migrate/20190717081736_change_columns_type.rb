class ChangeColumnsType < ActiveRecord::Migration[5.2]
  def change
    change_column(:posts, :body, :text)
    change_column(:articles, :body, :text)
  end
end
