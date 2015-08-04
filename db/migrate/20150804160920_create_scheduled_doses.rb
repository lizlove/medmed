class CreateScheduledDoses < ActiveRecord::Migration
  def change
    create_table :scheduled_doses do |t|

      t.timestamps null: false
    end
  end
end
