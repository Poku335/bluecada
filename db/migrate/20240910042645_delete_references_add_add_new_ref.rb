class DeleteReferencesAddAddNewRef < ActiveRecord::Migration[7.1]
  def change
    remove_column :cancer_forms, :information_diagnose_id
    add_reference :cancer_forms, :information_diagnoses, foreign_key: true
  end
end
