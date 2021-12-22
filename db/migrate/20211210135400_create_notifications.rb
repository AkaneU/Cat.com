class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :post_id
      t.string :post_comment_id
      t.string :visitor_id
      t.string :visited_id
      t.integer :action
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
