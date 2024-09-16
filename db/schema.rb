# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_09_16_085554) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "address_codes", force: :cascade do |t|
    t.integer "code"
    t.string "province"
    t.string "district"
    t.string "sub_district"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bases", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "behaviors", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cancer_form_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cancer_forms", force: :cascade do |t|
    t.integer "primary"
    t.boolean "is_editing"
    t.bigint "current_user_id"
    t.bigint "treatment_follow_up_id"
    t.bigint "treatment_information_id"
    t.bigint "cancer_information_id"
    t.bigint "patient_id"
    t.bigint "cancer_form_status_id"
    t.jsonb "additional_field_jsonb"
    t.string "tumor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "information_diagnosis_id"
    t.index ["cancer_form_status_id"], name: "index_cancer_forms_on_cancer_form_status_id"
    t.index ["cancer_information_id"], name: "index_cancer_forms_on_cancer_information_id"
    t.index ["current_user_id"], name: "index_cancer_forms_on_current_user_id"
    t.index ["information_diagnosis_id"], name: "index_cancer_forms_on_information_diagnosis_id"
    t.index ["patient_id"], name: "index_cancer_forms_on_patient_id"
    t.index ["treatment_follow_up_id"], name: "index_cancer_forms_on_treatment_follow_up_id"
    t.index ["treatment_information_id"], name: "index_cancer_forms_on_treatment_information_id"
  end

  create_table "cancer_informations", force: :cascade do |t|
    t.string "topography_description"
    t.bigint "basis_id"
    t.bigint "topography_code_id"
    t.bigint "laterality_id"
    t.string "morphology_description"
    t.bigint "behavior_id"
    t.bigint "lab_id"
    t.string "lab_num"
    t.string "lab_date"
    t.string "t_stage"
    t.string "n_stage"
    t.string "m_stage"
    t.bigint "stage_id"
    t.bigint "stage_other_id"
    t.bigint "extent_id"
    t.bigint "metastasis_site_id"
    t.boolean "is_recrr"
    t.string "recurr_date"
    t.bigint "grad_id"
    t.bigint "icdo_id"
    t.string "icd_10"
    t.string "age_at_diagnosis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "case_type_id"
    t.index ["basis_id"], name: "index_cancer_informations_on_basis_id"
    t.index ["behavior_id"], name: "index_cancer_informations_on_behavior_id"
    t.index ["case_type_id"], name: "index_cancer_informations_on_case_type_id"
    t.index ["extent_id"], name: "index_cancer_informations_on_extent_id"
    t.index ["grad_id"], name: "index_cancer_informations_on_grad_id"
    t.index ["icdo_id"], name: "index_cancer_informations_on_icdo_id"
    t.index ["lab_id"], name: "index_cancer_informations_on_lab_id"
    t.index ["laterality_id"], name: "index_cancer_informations_on_laterality_id"
    t.index ["metastasis_site_id"], name: "index_cancer_informations_on_metastasis_site_id"
    t.index ["stage_id"], name: "index_cancer_informations_on_stage_id"
    t.index ["stage_other_id"], name: "index_cancer_informations_on_stage_other_id"
    t.index ["topography_code_id"], name: "index_cancer_informations_on_topography_code_id"
  end

  create_table "case_types", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "death_stats", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "diagnose_paragraphs", force: :cascade do |t|
    t.string "diagnose_paragraph"
    t.bigint "cancer_information_id", null: false
    t.date "diag_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cancer_information_id"], name: "index_diagnose_paragraphs_on_cancer_information_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string "district_id"
    t.string "district_thai_short"
    t.string "district_eng_short"
    t.string "district_cnt"
    t.bigint "province_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["province_id"], name: "index_districts_on_province_id"
  end

  create_table "extents", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grads", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "health_insurances", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hospitals", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "icdos", force: :cascade do |t|
    t.integer "idd"
    t.string "beh"
    t.string "cancer_type"
    t.string "icdo_32"
    t.string "icdo_32_c"
    t.string "level"
    t.string "term_used"
    t.string "term_raw"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "import_patients", force: :cascade do |t|
    t.string "date"
    t.integer "total_patient_count"
    t.integer "new_patient_count"
    t.integer "existing_patient_count"
    t.integer "error_patient_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "information_diagnoses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tumor_marker_ca_19"
    t.string "tumor_marker_cea"
    t.string "tumor_marker_her_2"
    t.string "tumor_marker_afp"
    t.string "tumor_marker_hcg"
    t.string "tumor_marker_psa"
    t.string "tumor_suppressor_gene_brca_1"
    t.string "tumor_suppressor_gene_brca_2"
  end

  create_table "labs", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lateralities", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "marital_statuses", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metastasis_sites", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string "hos_no"
    t.bigint "hospital_id"
    t.string "name"
    t.string "citizen_id"
    t.bigint "sex_id"
    t.string "age"
    t.date "birth_date"
    t.string "address_detail"
    t.bigint "post_code_id"
    t.bigint "address_code_id"
    t.bigint "marital_status_id"
    t.bigint "race_id"
    t.bigint "religion_id"
    t.bigint "health_insurance_id"
    t.date "regis_date"
    t.string "id_finding"
    t.bigint "province_id"
    t.bigint "district_id"
    t.bigint "sub_district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_code_id"], name: "index_patients_on_address_code_id"
    t.index ["district_id"], name: "index_patients_on_district_id"
    t.index ["health_insurance_id"], name: "index_patients_on_health_insurance_id"
    t.index ["hospital_id"], name: "index_patients_on_hospital_id"
    t.index ["marital_status_id"], name: "index_patients_on_marital_status_id"
    t.index ["post_code_id"], name: "index_patients_on_post_code_id"
    t.index ["province_id"], name: "index_patients_on_province_id"
    t.index ["race_id"], name: "index_patients_on_race_id"
    t.index ["religion_id"], name: "index_patients_on_religion_id"
    t.index ["sex_id"], name: "index_patients_on_sex_id"
    t.index ["sub_district_id"], name: "index_patients_on_sub_district_id"
  end

  create_table "post_codes", force: :cascade do |t|
    t.integer "code"
    t.string "province"
    t.string "district"
    t.string "sub_district"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "presents", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string "province_id"
    t.string "province_thai"
    t.string "province_eng"
    t.string "region"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "races", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "religions", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_icdos", force: :cascade do |t|
    t.bigint "diagnose_paragraph_id", null: false
    t.bigint "icdo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagnose_paragraph_id"], name: "index_search_icdos_on_diagnose_paragraph_id"
    t.index ["icdo_id"], name: "index_search_icdos_on_icdo_id"
  end

  create_table "sexes", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stage_others", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stages", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_districts", force: :cascade do |t|
    t.string "sub_district_id"
    t.string "sub_district_thai_short"
    t.string "sub_district_eng_short"
    t.bigint "district_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_sub_districts_on_district_id"
  end

  create_table "topography_codes", force: :cascade do |t|
    t.string "code"
    t.string "icd_10"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treatment_follow_ups", force: :cascade do |t|
    t.bigint "present_id"
    t.date "dls"
    t.bigint "death_stat_id"
    t.bigint "refer_from_id"
    t.date "date_refer_from"
    t.bigint "refer_to_id"
    t.date "date_refer_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["death_stat_id"], name: "index_treatment_follow_ups_on_death_stat_id"
    t.index ["present_id"], name: "index_treatment_follow_ups_on_present_id"
    t.index ["refer_from_id"], name: "index_treatment_follow_ups_on_refer_from_id"
    t.index ["refer_to_id"], name: "index_treatment_follow_ups_on_refer_to_id"
  end

  create_table "treatment_informations", force: :cascade do |t|
    t.boolean "is_surg"
    t.string "date_surg"
    t.boolean "is_radia"
    t.string "date_radia"
    t.boolean "is_chemo"
    t.string "date_chemo"
    t.boolean "is_target"
    t.string "date_target"
    t.boolean "is_hormone"
    t.string "date_hormone"
    t.boolean "is_immu"
    t.string "date_immu"
    t.boolean "is_inter_the"
    t.string "date_inter_the"
    t.boolean "is_nuclear"
    t.string "date_nuclear"
    t.boolean "is_stem_cell"
    t.string "date_stem_cell"
    t.boolean "is_bone_scan"
    t.string "date_bone_scan"
    t.boolean "is_supportive"
    t.boolean "is_treatment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "user_name"
    t.string "password_digest"
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "cancer_forms", "cancer_form_statuses"
  add_foreign_key "cancer_forms", "cancer_informations"
  add_foreign_key "cancer_forms", "information_diagnoses"
  add_foreign_key "cancer_forms", "patients"
  add_foreign_key "cancer_forms", "treatment_follow_ups"
  add_foreign_key "cancer_forms", "treatment_informations"
  add_foreign_key "cancer_forms", "users", column: "current_user_id"
  add_foreign_key "cancer_informations", "bases"
  add_foreign_key "cancer_informations", "behaviors"
  add_foreign_key "cancer_informations", "case_types"
  add_foreign_key "cancer_informations", "extents"
  add_foreign_key "cancer_informations", "grads"
  add_foreign_key "cancer_informations", "icdos"
  add_foreign_key "cancer_informations", "labs"
  add_foreign_key "cancer_informations", "lateralities"
  add_foreign_key "cancer_informations", "metastasis_sites"
  add_foreign_key "cancer_informations", "stage_others"
  add_foreign_key "cancer_informations", "stages"
  add_foreign_key "cancer_informations", "topography_codes"
  add_foreign_key "diagnose_paragraphs", "cancer_informations", on_delete: :cascade
  add_foreign_key "districts", "provinces"
  add_foreign_key "patients", "address_codes"
  add_foreign_key "patients", "districts"
  add_foreign_key "patients", "health_insurances"
  add_foreign_key "patients", "hospitals"
  add_foreign_key "patients", "marital_statuses"
  add_foreign_key "patients", "post_codes"
  add_foreign_key "patients", "provinces"
  add_foreign_key "patients", "races"
  add_foreign_key "patients", "religions"
  add_foreign_key "patients", "sexes"
  add_foreign_key "patients", "sub_districts"
  add_foreign_key "search_icdos", "diagnose_paragraphs", on_delete: :cascade
  add_foreign_key "search_icdos", "icdos"
  add_foreign_key "sub_districts", "districts"
  add_foreign_key "treatment_follow_ups", "death_stats"
  add_foreign_key "treatment_follow_ups", "hospitals", column: "refer_from_id"
  add_foreign_key "treatment_follow_ups", "hospitals", column: "refer_to_id"
  add_foreign_key "treatment_follow_ups", "presents"
  add_foreign_key "users", "roles"
end
