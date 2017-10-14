class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :author_id, null: false
      t.datetime :published_at, null: false

      t.timestamps
    end

    add_index :posts, :author_id
    add_index :posts, :published_at
  end
end
