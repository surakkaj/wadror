class EditFrozenFromUser < ActiveRecord::Migration
  def change
  	rename_column :users, :frozen, :iced
  end
end
