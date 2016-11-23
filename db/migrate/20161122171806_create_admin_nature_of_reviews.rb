class CreateAdminNatureOfReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_nature_of_reviews do |t|
      t.string :title
      t.string :user_id
      t.string :review_type

      t.timestamps
    end
  end
end
