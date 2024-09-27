require "csv"
require 'securerandom'
namespace :db do
  desc 'Create master data'
  task create_master_data: :environment do

    create_or_update_data class: CancerFormStatus, keys: [:id], reset_pkey: false,
      data: [
        {id: 1, name: "กำลังดำเนินการ"},
        {id: 2, name: "เสร็จสิ้น"},
      ]

    create_or_update_data class: Role, keys: [:id], reset_pkey: false,
      data: [
        {id: 1, name: "Admin"},
      ]

    create_or_update_data class: CaseType, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "Case finding", code: 1},
        {id: 2, name: "Register CA", code: 2},
        {id: 3, name: "No CA", code: 3},
        {id: 4, name: "Pending CA", code: 4},
        {id: 5, name: "register CA and low basis", code: 5}
      ]

    create_or_update_data class: Religion, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "พุทธ", code: 1},
        {id: 2, name: "คริสต์", code: 2},
        {id: 3, name: "อิสลาม", code: 3},
        {id: 4, name: "อื่นๆ", code: 8},
        {id: 5, name: "ไม่ทราบ", code: 9}
      ]

      create_or_update_data class: Sex, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "ชาย", code: 1},
        {id: 2, name: "หญิง", code: 2},
      ]

    create_or_update_data class: MetastasisSite, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "Lymph node", code: 1},
        {id: 2, name: "Bone", code: 2},
        {id: 3, name: "Liver", code: 3},
        {id: 4, name: "Lung / Pleura", code: 4},
        {id: 5, name: "Brain", code: 5},
        {id: 6, name: "Peritoneum", code: 6},
        {id: 7, name: "CNS or CSF Pathway", code: 7},
        {id: 8, name: "Other", code: 8},
        {id: 9, name: "Multiple sites", code: 9}
      ]

    create_or_update_data class: HealthInsurance, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "สามสิบบาท", code: 1},
        {id: 2, name: "ประกันสังคม", code: 2},
        {id: 3, name: "ข้าราชการ, ต้นสังกัด", code: 3},
        {id: 4, name: "ประกันชีวิต", code: 4},
        {id: 5, name: "อื่นๆ", code: 5}
      ]

    create_or_update_data class: Race, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "ไทย", code: 1},
        {id: 2, name: "จีน", code: 2},
        {id: 3, name: "ลาว", code: 3},
        {id: 4, name: "เวียตนาม", code: 4},
        {id: 5, name: "มาเลย์", code: 5},
        {id: 6, name: "ชาวเขา", code: 6},
        {id: 7, name: "อื่นๆ", code: 8},
        {id: 8, name: "ไม่ระบุ", code: 9}
      ]
    
    create_or_update_data class: MaritalStatus, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "โสด", code: 1},
        {id: 2, name: "สมรส/หม้าย/หย่า", code: 2},
        {id: 3, name: "นักบวช", code: 3},
        {id: 4, name: "ไม่ระบุ", code: 9}
      ]
    
      create_or_update_data class: Basis, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "Death Certificate Only", code: 0},
        {id: 2, name: "History & Physical exam.", code: 1},
        {id: 3, name: "Endoscopy & Radiology", code: 2},
        {id: 4, name: "Surgery & Autopsy (no histol.)", code: 3},
        {id: 5, name: "Specific Biochem/Immuno tests", code: 4},
        {id: 6, name: "Cytology or Hematology", code: 5},
        {id: 7, name: "Histology of Metastasis", code: 6},
        {id: 8, name: "Histology of Primary", code: 7},
        {id: 9, name: "Autopsy with Histology", code: 8},
        {id: 10, name: "Not known", code: 9}
      ]

    create_or_update_data class: Laterality, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "Right", code: 1},
        {id: 2, name: "Left", code: 2},
        {id: 3, name: "Bilateral", code: 3},
        {id: 4, name: "Uni-taeral,Unspeccified", code: 4},
        {id: 5, name: "Not applicable", code: 8},
        {id: 6, name: "Unknown", code: 9}
      ]
    
    create_or_update_data class: Behavior, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "Benign", code: 0},
        {id: 2, name: "Uncertain ben/malig", code: 1},
        {id: 3, name: "In situ", code: 2},
        {id: 4, name: "Malignant", code: 3}
      ]

    create_or_update_data class: Lab, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "ศรีนครินทร์", code: 1},
        {id: 2, name: "รพ.ขอนแก่น", code: 2},
        {id: 3, name: "ศอด. เขต 6", code: 3},
        {id: 4, name: "รพ.ราชพฤกษ์", code: 4},
        {id: 5, name: "ศอด. พล", code: 5},
        {id: 6, name: "ศูนย์พยาธิ กทม.", code: 6}
      ]

    create_or_update_data class: Stage, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "Stage 0", code: 0},
        {id: 2, name: "Stage I", code: 1},
        {id: 3, name: "Stage II", code: 2},
        {id: 4, name: "Stage III", code: 3},
        {id: 5, name: "Stage IV", code: 4},
        {id: 6, name: "Stage IVs", code: 5},
        {id: 7, name: "Unknown", code: 9}
      ]

    create_or_update_data class: Extent, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "In situ", code: 1},
        {id: 2, name: "Localized", code: 2},
        {id: 3, name: "Direct extension", code: 3},
        {id: 4, name: "Regional lymph.", code: 4},
        {id: 5, name: "Distant metas.", code: 5},
        {id: 6, name: "Not applicable", code: 8},
        {id: 7, name: "Unknown", code: 9}
      ]

      create_or_update_data class: Grad, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "Well differentiated", code: 1},
        {id: 2, name: "Moderately differ'd", code: 2},
        {id: 3, name: "Poorly differ'd", code: 3},
        {id: 4, name: "Undifferentiated", code: 4},
        {id: 5, name: "Positive T-cell", code: 5},
        {id: 6, name: "Positive B-cell", code: 6},
        {id: 7, name: "Null cell (Non T-non B)", code: 7},
        {id: 8, name: "NK cell (Natural killer cell)", code: 8},
        {id: 9, name: "Not known", code: 9}
      ]

    create_or_update_data class: Present, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "มีชีวิต", code: 1},
        {id: 2, name: "เสียชีวิต", code: 2}
      ]

    create_or_update_data class: DeathStat, keys: [:code], reset_pkey: false,
      data: [
        {id: 1, name: "มะเร็ง", code: 1},
        {id: 2, name: "อื่นๆ", code: 2},
        {id: 3, name: "ไม่ทราบ", code: 9}
      ]

    create_or_update_data class: User, keys: [:id], reset_pkey: false,
      data: [
        {id: 1, name: "Admin", user_name: "Admin", password: "0000", role_id: 1},
      ]
  

    # import_provinces
    # import_districts
    # import_sub_districts
    # import_postcode_data
    # import_address_code_data
    # import_hospital
    # import_topo
    # import_icdo
  end

end

def import_provinces
  SubDistrict.delete_all
  District.delete_all
  Province.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!("provinces")
  CSV.foreach('lib/csv_files/Province.csv', headers: true) do |row|
    Province.create!(
      province_id: row["ProvinceID"],
      province_thai: row['ProvinceThai'],
      province_eng: row['ProvinceEng'],
      region: row['Region']
    )
  end
end

def import_postcode_data
  PostCode.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!("post_codes")
  ActiveRecord::Base.transaction do
    CSV.foreach('lib/csv_files/post_code.csv', headers: true) do |row|
      province_name, district_name, sub_district_name = row['Postcode'].split('|')
      PostCode.create!(
        code: row["CODE"].to_i,
        province: province_name,
        district: district_name,
        sub_district: sub_district_name
      )
    end
  end
end


def import_icdo
  Icdo.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!("icdos")
  ActiveRecord::Base.transaction do
    CSV.foreach('lib/csv_files/icdo.csv', headers: true) do |row|

      Icdo.create!(
        icdo_32: row["ICDO3.2"],
        icdo_32_c: row["ICDO3.2_c"],
        idd: row["idd"],
        beh: row["beh"].gsub("/", ""),
        cancer_type: row["type"],
        level: row["Level"],
        term_used: row["Term_used"],
        term_raw: row["Term_raw"]
      )
    end
  end
end


def import_address_code_data
  AddressCode.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!("address_codes")
  ActiveRecord::Base.transaction do
    CSV.foreach('lib/csv_files/address_code.csv', headers: true) do |row|
      province_name, district_name, sub_district_name = row['Address Code'].split('|')

      AddressCode.create!(
        code: row["CODE"].to_i,
        province: province_name,
        district: district_name,
        sub_district: sub_district_name
      )
    end
  end
end


def import_hospital
  Hospital.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!("hospitals")
  ActiveRecord::Base.transaction do
    CSV.foreach('lib/csv_files/hospital.csv', headers: true) do |row|

      Hospital.create!(
        code: row["code"],
        name: row["hospital"]
      )
    end
  end
end

def import_topo
  TopographyCode.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!("topography_codes")
  ActiveRecord::Base.transaction do
    CSV.foreach('lib/csv_files/topo_code.csv', headers: true) do |row|

      TopographyCode.create!(
        code: row["code"],
        icd_10: row["icd-10"],
        name: row["Topography"]
     
      ) 
    end
  end
end


def import_districts
  ActiveRecord::Base.connection.reset_pk_sequence!("districts")
  CSV.foreach('lib/csv_files/District.csv', headers: true) do |row|
    province = Province.find_by(province_id: row["ProvinceID"])
    if province
      District.create!(
        district_id: row['DistrictID'],
        district_thai_short: row['DistrictThaiShort'],
        district_eng_short: row['DistrictEngShort'],
        district_cnt: row['DistrictCNT'],
        province_id: province.id
      )
    else
      puts "Province with ID #{row['ProvinceID']} not found"
    end
  end
end

def import_sub_districts
  ActiveRecord::Base.connection.reset_pk_sequence!("sub_districts")
  CSV.foreach('lib/csv_files/Tambon.csv', headers: true) do |row|
    district = District.find_by(district_id: row['DistrictID'])
    if district
      SubDistrict.create!(
        sub_district_id: row['TambonID'],
        sub_district_thai_short: row['TambonThaiShort'],
        sub_district_eng_short: row['TambonEngShort'],
        district_id: district.id
      )
    else
      puts "District with ID #{row['DistrictID']} not found"
    end
  end
end


  private

  def create_or_update_data(hsh = {})
    cls = hsh[:class]
    arr_data = hsh[:data]
    keys = hsh[:keys]

    if hsh[:reset_pkey]
      cls.delete_all
      ActiveRecord::Base.connection.reset_pk_sequence!(cls.table_name)
    end

    new_record_count = 0
    arr_data.each do |data|
      keys_hsh = {}
      keys.each do |k|
        keys_hsh[k] = (data.class == String ? data : data[k])
      end

      # fix => {id:1, name:""} will not increment pkey sequence
      data.delete(:id) if data.class != String && data[:id].present?

      obj = cls.where(keys_hsh).first || cls.new
      new_record_count += 1 if obj.new_record?
      obj.attributes = (data.class == String ? keys_hsh : data)
      obj.save
    end
    p "#{new_record_count} #{cls} created"
  end




