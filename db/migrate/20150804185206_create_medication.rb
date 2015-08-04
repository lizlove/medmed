class CreateMedication < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.text :name
      t.integer :rxcui
    end
  end
end
