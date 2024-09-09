class CreateDiagnoseParagraphs < ActiveRecord::Migration[7.1]
  def change
    create_table :diagnose_paragraphs do |t|
      t.string :diagnose_paragraph
      t.references :cancer_information, null: false, foreign_key: {on_delete: :cascade}
      t.date :diag_date

      t.timestamps
    end
  end
end
