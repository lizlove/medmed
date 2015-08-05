class AddColumnsToPrescriptions < ActiveRecord::Migration
  def change
    add_column :prescriptions, :doctor_id, :integer
    add_column :prescriptions, :side_effects, :text
    add_column :prescriptions, :image_url, :string
    rename_column :prescriptions, :medication_id, :rxcui
    add_column :prescriptions, :medication_name, :string
    remove_column :prescriptions, :dose
  end
end
