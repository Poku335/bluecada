class CreateIcdos < ActiveRecord::Migration[7.1]
  def change
    create_table :icdos do |t|
      t.integer :idd
      t.string :beh
      t.string :cancer_type
      t.string :icdo_32
      t.string :icdo_32_c
      t.string :level
      t.string :term_used
      t.string :term_raw

      t.timestamps
    end
  end
end
