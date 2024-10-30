class AddMissingColumn2 < ActiveRecord::Migration[7.1]
  def change
    add_column :diagnose_paragraphs, :hos_no, :string
    change_column_null :diagnose_paragraphs, :cancer_information_id, true
  end
end
