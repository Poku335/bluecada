class CreateInformationDiagnoses < ActiveRecord::Migration[7.1]
  def change
    create_table :information_diagnoses do |t|
      t.string :tumor_marker
      t.string :tumor_suppressor_gene

      t.timestamps
    end
  end
end
