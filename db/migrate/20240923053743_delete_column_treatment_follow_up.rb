class DeleteColumnTreatmentFollowUp < ActiveRecord::Migration[7.1]
  def change
    remove_column :treatment_follow_ups, :dls
    remove_column :treatment_follow_ups, :date_refer_from
    remove_column :treatment_follow_ups, :date_refer_to
  end
end
