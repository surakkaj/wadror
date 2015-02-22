class AddFrozenToUser < ActiveRecord::Migration
  def change
    add_column :users, :frozen, :boolean
  end
end
