class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :name
      t.integer :user_id
      t.text :email
      t.text :password
      t.text :genre

      t.timestamps
    end
  end
end
