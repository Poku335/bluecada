class CreateDistricts < ActiveRecord::Migration[7.1]
  def change
    create_table :districts do |t|
      t.string :district_id
      t.string :district_thai_short
      t.string :district_eng_short
      t.string :district_cnt
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
