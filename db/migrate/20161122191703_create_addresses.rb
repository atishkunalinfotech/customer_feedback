class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :town_id
      t.integer :location_id
      t.integer :company_id

      t.timestamps
    end
  end
end
