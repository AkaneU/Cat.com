class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :end_user_id
      t.string :image_id
      t.string :title
      t.string :text

      t.timestamps
    end
  end
end
