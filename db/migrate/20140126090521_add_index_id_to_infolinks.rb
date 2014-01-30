class AddIndexIdToInfolinks < ActiveRecord::Migration
  def change
    add_column :infolinks, :index_id, :integer
  end
end
