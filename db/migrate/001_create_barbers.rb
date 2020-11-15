class CreateBarbers < ActiveRecord::Migration[6.0]
    def change
      create_table :barbers do |t|
        t.string :name
        t.string :phone_number
        t.string :skills
  
        t.timestamps
      end
    end
  end
  