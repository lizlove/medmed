class AddColumntoPrescriptions < ActiveRecord::Migration
  def change
    add_column :prescriptions, :label, :text
  end
end
