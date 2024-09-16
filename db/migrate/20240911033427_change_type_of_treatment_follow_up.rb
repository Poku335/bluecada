class ChangeTypeOfTreatmentFollowUp < ActiveRecord::Migration[7.1]
  def change
    change_column :treatment_follow_ups, :dls, 'date USING NULLIF(dls, \'\')::date'
    change_column :treatment_follow_ups, :date_refer_from, 'date USING NULLIF(date_refer_from, \'\')::date'
    change_column :treatment_follow_ups, :date_refer_to, 'date USING NULLIF(date_refer_to, \'\')::date'
  end
end
