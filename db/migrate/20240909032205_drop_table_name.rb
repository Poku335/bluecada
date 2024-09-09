class DropTableName < ActiveRecord::Migration[7.1]
  def change
    drop_table :diagnose_informations
  end
end
