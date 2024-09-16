class AddColumnAndRemovecolumn < ActiveRecord::Migration[7.1]
  def change
    add_column :information_diagnoses, :tumor_marker_ca_19, :string
    add_column :information_diagnoses, :tumor_marker_cea, :string
    add_column :information_diagnoses, :tumor_marker_her_2, :string
    add_column :information_diagnoses, :tumor_marker_afp, :string
    add_column :information_diagnoses, :tumor_marker_hcg, :string
    add_column :information_diagnoses, :tumor_marker_psa, :string
    add_column :information_diagnoses, :tumor_suppressor_gene_brca_1, :string
    add_column :information_diagnoses, :tumor_suppressor_gene_brca_2, :string
    remove_column :information_diagnoses, :tumor_marker, :string
    remove_column :information_diagnoses, :tumor_suppressor_gene, :string
  end
end
