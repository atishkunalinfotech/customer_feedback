class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :title
      t.integer :user_id
      t.integer :industry_id
      t.boolean :is_registered, :default => false

      t.timestamps
    end
  end
end
