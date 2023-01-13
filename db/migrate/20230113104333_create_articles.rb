class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.integer :customer_id,null: false
      t.integer :genre_id,null: false
      t.string :question,null: false
      t.string :answer,null: false
      t.timestamps
    end
  end
end

