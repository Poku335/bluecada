class AddMissingColumn3 < ActiveRecord::Migration[7.1]
  def change
    add_column :cancer_informations, :remark1, :string
    add_column :cancer_informations, :remark2, :string
    add_column :cancer_informations, :remark3, :string
    add_column :cancer_informations, :remark4, :string

    add_column :information_diagnoses, :remark1, :string
    add_column :information_diagnoses, :remark2, :string
    add_column :information_diagnoses, :remark3, :string
    add_column :information_diagnoses, :remark4, :string

    add_column :patients, :icdo_10_date, :date
  end
end
