class CreateCancerForms < ActiveRecord::Migration[7.1]
  def change
    create_table :cancer_forms do |t|
      t.integer :primary
      t.boolean :is_editing
      t.references :current_user, foreign_key: { to_table: :users }
      t.references :treatment_follow_up, foreign_key: true
      t.references :information_diagnose, foreign_key: true
      t.references :treatment_information, foreign_key: true
      t.references :cancer_information, foreign_key: true
      t.references :patient, foreign_key: true
      t.references :cancer_form_status, foreign_key: true
      t.jsonb :additional_field_jsonb
      t.string :tumor_id

      t.timestamps
    end
  end
end
