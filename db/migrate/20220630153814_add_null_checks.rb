class AddNullChecks < ActiveRecord::Migration[7.0]
  def change
    change_column_null :posts, :title, false
    change_column_null :posts, :body, false
    change_column_null :comments, :body, false
  end
end
