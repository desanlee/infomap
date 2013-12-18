class CreateInfolinks < ActiveRecord::Migration
  def change
    create_table :infolinks do |t|
      t.integer :frompiece_id
      t.integer :topiece_id

      t.timestamps
    end
  end
end
