class AddColumnTreatmentFollowUp < ActiveRecord::Migration[7.1]
  def change
    add_column :treatment_follow_ups, :dls ,:date
    add_column :treatment_follow_ups, :date_refer_from ,:date
    add_column :treatment_follow_ups, :date_refer_to ,:date
  end
end
