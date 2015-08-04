class CreateMedicines < ActiveRecord::Migration
  def change
    create_table :medicines do |t|

      t.timestamps null: false
    end
  end
end
