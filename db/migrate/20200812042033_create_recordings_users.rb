class CreateRecordingsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :recordings_users do |t|
      t.integer :user_id
      t.integer :recording_id
    end
  end
end