class AddColumntoPatients < ActiveRecord::Migration
  def change
    add_column :patients, :time_zone, :string
  end
end
