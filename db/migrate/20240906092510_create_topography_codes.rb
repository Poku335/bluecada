class CreateTopographyCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :topography_codes do |t|
      t.string :code
      t.string :icd_10
      t.string :name

      t.timestamps
    end
  end
end
