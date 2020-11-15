class AddHairtypeColumnsToClients < ActiveRecord::Migration[6.0]
    def change
      add_column :clients, :hair_type, :string
    end
  end
  

