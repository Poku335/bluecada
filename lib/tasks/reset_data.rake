namespace :db do
  desc "Reset primary key sequences and delete all data from all tables"
  task reset_data: :environment do
    ActiveRecord::Base.connection.tables.each do |table|
      next if table == 'schema_migrations' || table == 'ar_internal_metadata'

      # ลบข้อมูลในตาราง
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE")

      # รีเซ็ต primary key sequence
      ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end

    puts "All data deleted and primary key sequences reset."
  end
end