class CreateTreatmentInformations < ActiveRecord::Migration[7.1]
  def change
    create_table :treatment_informations do |t|
      t.boolean :is_surg
      t.date :date_surg
      t.boolean :is_radia
      t.date :date_radia
      t.boolean :is_chemo
      t.date :date_chemo
      t.boolean :is_target
      t.date :date_target
      t.boolean :is_hormone
      t.date :date_hormone
      t.boolean :is_immu
      t.date :date_immu
      t.boolean :is_inter_the
      t.date :date_inter_the
      t.boolean :is_nuclear
      t.date :date_nuclear
      t.boolean :is_stem_cell
      t.date :date_stem_cell
      t.boolean :is_bone_scan
      t.date :date_bone_scan
      t.boolean :is_supportive
      t.boolean :is_treatment

      t.timestamps
    end
  end
end
