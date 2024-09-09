class CreateSubDistricts < ActiveRecord::Migration[7.1]
  def change
    create_table :sub_districts do |t|
      t.string :sub_district_id
      t.string :sub_district_thai_short
      t.string :sub_district_eng_short
      t.references :district, null: false, foreign_key: true

      t.timestamps
    end
  end
end
