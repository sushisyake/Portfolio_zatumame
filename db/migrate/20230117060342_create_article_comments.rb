class CreateArticleComments < ActiveRecord::Migration[6.1]
  def change
    create_table :article_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :article_id
      t.timestamps
    end
  end
end
