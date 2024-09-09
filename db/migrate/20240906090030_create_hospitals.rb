class CreateHospitals < ActiveRecord::Migration[7.1]
  def change
    create_table :hospitals do |t|
      t.integer :code
      t.string :name

      t.timestamps
    end
  end
end
