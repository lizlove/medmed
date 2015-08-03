class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
      t.integer :patient_id
      t.integer :medication_id
      t.string :dose
      t.text :recurrence
      t.datetime :start
      t.datetime  :end

    end
  end
end
