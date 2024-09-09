class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :hos_no
      t.references :hospital, foreign_key: true
      t.string :name
      t.string :citizen_id
      t.references :sex, foreign_key: true
      t.string :age
      t.date :birth_date
      t.string :address_detail
      t.references :post_code, foreign_key: true
      t.references :address_code, foreign_key: true
      t.references :marital_status, foreign_key: true
      t.references :race, foreign_key: true
      t.references :religion, foreign_key: true
      t.references :health_insurance, foreign_key: true
      t.date :regis_date
      t.string :id_finding
      t.references :province, foreign_key: true
      t.references :district, foreign_key: true
      t.references :sub_district, foreign_key: true

      t.timestamps
    end
  end
end
