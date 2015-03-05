class RenameDiarys < ActiveRecord::Migration
  def change
    rename_table :diarys, :diaries
  end
end
