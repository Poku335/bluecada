class CreateProvinces < ActiveRecord::Migration[7.1]
  def change
    create_table :provinces do |t|
      t.string :province_id
      t.string :province_thai
      t.string :province_eng
      t.string :region

      t.timestamps
    end
  end
end
