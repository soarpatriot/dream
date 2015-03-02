class DropDailys < ActiveRecord::Migration
  def change
    drop_table :dailys
  end
end
