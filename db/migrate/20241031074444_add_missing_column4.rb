class AddMissingColumn4 < ActiveRecord::Migration[7.1]
  def change
    add_column :cancer_informations, :diagnosis_age, :integer
  end
end
