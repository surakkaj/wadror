class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :style
      t.text :desc
    end
  end
end
