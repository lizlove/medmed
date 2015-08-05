class DropMedications < ActiveRecord::Migration
  def change
    drop_table :medications
  end
end
