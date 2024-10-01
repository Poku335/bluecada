class AddDiagnosisDate < ActiveRecord::Migration[7.1]
  def change
    add_column :cancer_informations, :diagnosis_date ,:date
  end
end
