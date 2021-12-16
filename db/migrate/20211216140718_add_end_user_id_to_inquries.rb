class AddEndUserIdToInquries < ActiveRecord::Migration[5.2]
  def change
    add_column :inquiries, :end_user_id, :integer
  end
end
