class ChangeColumnNamesInPrescriptions < ActiveRecord::Migration
  def change
    rename_column :prescriptions, :end, :end_datetime
    rename_column :prescriptions, :start, :start_datetime
  end
end
