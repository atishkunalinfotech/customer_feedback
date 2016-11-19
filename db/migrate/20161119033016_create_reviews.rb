class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :industry_id
      t.integer :company_id
      t.date :date
      t.integer :town_id
      t.time :datetime
      t.integer :location_id
      t.string :personal_responsible
      t.string :nature_of_review
      t.text :message
      t.string :account_details
      t.string :ticket_number
      t.string :review_type
      t.integer :user_id
      t.string :guest_token
      t.string :file
      t.boolean :archive,  default: false
      t.boolean :ispublished,default: false
      t.datetime :published_date
      t.datetime :change_date
      t.text :modified_review
      t.boolean :is_modified
      t.text :notes
      t.boolean :archive_attachment,default: false
      t.boolean :is_ticket_open,default: true
      t.integer :jagent_id
      t.integer :agent_id
      t.integer :old_jagent_id
      t.integer :last_published_agent_id
      t.boolean :admin_sagent_modified,default: false 
      t.string :desired_outcome
      t.integer :old_agent_id

      t.timestamps
    end
  end
end
