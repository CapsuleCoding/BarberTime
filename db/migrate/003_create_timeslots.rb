class CreateTimeslots < ActiveRecord::Migration[6.0]
    def change
      create_table :timeslots do |t|
        t.references :barber, null: false, foreign_key: true
        t.references :client, null: false, foreign_key: true
        t.string :address
        t.datetime :start_time
        t.datetime :end_time
  
        t.timestamps
      end
    end
  end
  