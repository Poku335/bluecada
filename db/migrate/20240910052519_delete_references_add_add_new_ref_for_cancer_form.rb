class DeleteReferencesAddAddNewRefForCancerForm < ActiveRecord::Migration[7.1]
  def change
    remove_column :cancer_forms, :information_diagnoses_id
    add_reference :cancer_forms, :information_diagnosis, foreign_key: true
    remove_column :cancer_informations, :case_types_id
    add_reference :cancer_informations, :case_type, foreign_key: true
  end
end
