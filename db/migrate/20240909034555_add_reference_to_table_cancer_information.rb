class AddReferenceToTableCancerInformation < ActiveRecord::Migration[7.1]
  def change
    add_reference :cancer_informations, :case_types, foreign_key: true
    Rake::Task['db:create_master_data'].invoke
  end
end
