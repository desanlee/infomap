class AddRcountToInfopieces < ActiveRecord::Migration
  def change
    add_column :infopieces, :rcount, :integer
  end
end
