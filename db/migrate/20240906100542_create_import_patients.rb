class CreateImportPatients < ActiveRecord::Migration[7.1]
  def change
    create_table :import_patients do |t|
      t.date :date
      t.integer :total_patient_count
      t.integer :new_patient_count
      t.integer :existing_patient_count
      t.integer :error_patient_count

      t.timestamps
    end
  end
end
