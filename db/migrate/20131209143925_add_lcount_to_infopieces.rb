class AddLcountToInfopieces < ActiveRecord::Migration
  def change
    add_column :infopieces, :lcount, :integer
  end
end
