class AddLabelstrToInfopieces < ActiveRecord::Migration
  def change
    add_column :infopieces, :labelstr, :string
  end
end
