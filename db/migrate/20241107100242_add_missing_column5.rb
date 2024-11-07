class AddMissingColumn5 < ActiveRecord::Migration[7.1]
  def change
    # First, remove any foreign key constraint on stage_other_id if it exists
    remove_foreign_key :cancer_informations, column: :stage_other_id if foreign_key_exists?(:cancer_informations, column: :stage_other_id)
    
    # Now rename the column and change its type to string
    rename_column :cancer_informations, :stage_other_id, :stage_other
    change_column :cancer_informations, :stage_other, :string, null: true

    # Add new columns
    add_column :cancer_informations, :date_stage, :datetime
    add_column :cancer_informations, :postneo_tnm, :string
    add_column :cancer_informations, :postneo_date, :datetime

    # Add references (foreign keys) for new associations
    add_reference :cancer_informations, :type_stage, foreign_key: true
    add_reference :cancer_informations, :figo, foreign_key: true
    add_reference :cancer_informations, :bclc, foreign_key: true
    add_reference :cancer_informations, :postneo, foreign_key: true
    add_reference :cancer_informations, :postneo_staging, foreign_key: true
    add_reference :cancer_informations, :ecog, foreign_key: true
  end
end
