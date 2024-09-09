class CreateCancerInformations < ActiveRecord::Migration[7.1]
  def change
    create_table :cancer_informations do |t|
      t.string :topography_description
      t.references :basis, foreign_key: true
      t.references :topography_code, foreign_key: true
      t.references :laterality, foreign_key: true
      t.string :morphology_description
      t.references :behavior, foreign_key: true
      t.references :lab, foreign_key: true
      t.string :lab_num
      t.date :lab_date
      t.string :t_stage
      t.string :n_stage
      t.string :m_stage
      t.references :stage, foreign_key: true
      t.references :stage_other, foreign_key: true
      t.references :extent, foreign_key: true
      t.references :metastasis_site, foreign_key: true
      t.boolean :is_recrr
      t.date :recurr_date
      t.references :grad, foreign_key: true
      t.references :icdo, foreign_key: true
      t.string :icd_10
      t.string :age_at_diagnosis

      t.timestamps
    end
  end
end
