class CreateInfopieces < ActiveRecord::Migration
  def change
    create_table :infopieces do |t|
      t.integer :user_id
      t.string :content

      t.timestamps
    end
  end
end
