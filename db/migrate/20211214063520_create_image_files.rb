class CreateImageFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :image_files do |t|
      t.string :image_id
      t.integer :post_id

      t.timestamps
    end
  end
end
