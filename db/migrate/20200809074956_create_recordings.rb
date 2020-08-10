class CreateRecordings < ActiveRecord::Migration[5.2]
  def change
    create_table :recordings do |t|
      t.text :file
      t.integer :sequence_id
      t.integer :user_id

      t.timestamps
    end
  end
end
