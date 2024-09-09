class CreateTreatmentFollowUps < ActiveRecord::Migration[7.1]
  def change
    create_table :treatment_follow_ups do |t|
      t.references :present,  foreign_key: true
      t.date :dls
      t.references :death_stat, foreign_key: true
      t.references :refer_from,  foreign_key: { to_table: :hospitals }
      t.date :date_refer_from
      t.references :refer_to, foreign_key: { to_table: :hospitals }
      t.date :date_refer_to

      t.timestamps
    end
  end
end
