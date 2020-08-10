class CreateSequences < ActiveRecord::Migration[5.2]
  def change
    create_table :sequences do |t|
      t.text :name
      t.text :key
      t.text :scale
      t.text :data
      t.integer :user_id
      t.integer :bpm

      t.timestamps
    end
  end
end
