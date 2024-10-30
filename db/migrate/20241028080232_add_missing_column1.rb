class AddMissingColumn1 < ActiveRecord::Migration[7.1]
  def change
    add_column :diagnose_paragraphs, :vali_date, :date
    add_column :diagnose_paragraphs, :received_date, :date
  end
end
