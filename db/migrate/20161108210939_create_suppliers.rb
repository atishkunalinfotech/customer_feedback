class CreateSuppliers < ActiveRecord::Migration[5.0]
  def change
    create_table :suppliers do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :address_line1
      t.string :address_line2
      t.string :town
      t.string :city
      t.string :country
      t.string :title
      t.string :telephone_number
      t.string :mobile_number
      t.string :subscription
      t.date :start_date
      t.date :end_date
      t.string :supplier_name
      t.string :supplier_vat_number
      t.string :industry
      t.string :authorised_responder
      t.text :notes

      t.timestamps
    end
  end
end
