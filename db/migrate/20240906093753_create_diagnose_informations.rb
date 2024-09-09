class CreateDiagnoseInformations < ActiveRecord::Migration[7.1]
  def change
    create_table :diagnose_informations do |t|
      t.string :diagnose_paragraph
      t.references :cancer_information, null: false, foreign_key: true
      t.date :diag_date

      t.timestamps
    end
  end
end
