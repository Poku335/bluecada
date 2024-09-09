class CreateSearchIcdos < ActiveRecord::Migration[7.1]
  def change
    create_table :search_icdos do |t|
      t.references :diagnose_paragraph, null: false, foreign_key: {on_delete: :cascade}
      t.references :icdo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
