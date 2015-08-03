class CreateScheduledDoses < ActiveRecord::Migration
  def change
    create_table :scheduled_doses do |t|
      t.integer :prescription_id
      t.datetime :scheduled_time
      t.datetime :taken_time
      t.text :side_effect
      t.boolean :was_taken
    end
  end
end
