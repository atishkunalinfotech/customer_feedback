class AddUserFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :unconfirmed_email, :string
    add_column :users, :secret_question, :string
    add_column :users, :answer, :string
    add_column :users, :role_id, :integer,default: 4
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :age, :string
    add_column :users, :dob, :date
    add_column :users, :country, :string
    add_column :users, :pobox, :string
    add_column :users, :postal_code, :integer
    add_column :users, :town, :string
    add_column :users, :lives_in, :string
    add_column :users, :avatar, :string
    add_column :users, :address_line1, :string
    add_column :users, :address_line2, :string
    add_column :users, :role, :string,:default => 'user'
    add_column :users, :preferred_alias, :string
    add_column :users, :accept_t_and_c, :boolean, default: false
    add_column :users, :guest_token, :string
    add_column :users, :is_subscribe, :boolean
  end
end
