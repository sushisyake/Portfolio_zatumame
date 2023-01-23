class CreateUnfavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :unfavorites do |t|
      
      t.integer :user_id
      t.integer :article_id

      t.timestamps
    end
  end
end
