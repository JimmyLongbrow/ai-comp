class AddNewToRecordings < ActiveRecord::Migration[5.2]
  def change
    add_column :recordings, :comments, :text
    add_column :recordings, :likes, :integer
  end
end
