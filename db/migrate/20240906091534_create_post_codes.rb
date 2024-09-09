class CreatePostCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :post_codes do |t|
      t.integer :code
      t.string :province
      t.string :district
      t.string :sub_district

      t.timestamps
    end
  end
end
