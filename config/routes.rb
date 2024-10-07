Rails.application.routes.draw do
  # resources :case_types
  # resources :diagnose_paragraphs
  # resources :patients
  # resources :information_diagnoses
  # resources :cancer_forms
  # resources :treatment_informations
  # resources :import_patients
  # resources :treatment_follow_ups
  # resources :death_stats
  # resources :presents
  # resources :cancer_form_statuses
  # resources :search_icdos
  # resources :diagnose_informations
  # resources :cancer_informations
  # resources :bases
  # resources :topography_codes
  # resources :lateralities
  # resources :behaviors
  # resources :icdos
  # resources :grads
  # resources :metastasis_sites
  # resources :extents
  # resources :stage_others
  # resources :stages
  # resources :labs
  # resources :sexes
  # resources :post_codes
  # resources :address_codes
  # resources :marital_statuses
  # resources :races
  # resources :sub_districts
  # resources :districts
  # resources :provinces
  # resources :health_insurances
  # resources :religions
  # resources :users
  # resources :hospitals
  # resources :roles

  # post '/import/patient', to: 'application#import_patient'
  # post "/login", to: "application#login" 
  # # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # # post '/import/diagnose', to: 'application#import_diag_paragraph'
  # get '/export/patient', to: 'application#export_patients'

  # post '/import/diagnose', to: 'diagnose_paragraph#import_diag'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


    scope '' do
      match '/login', to: 'users#login', via: %i[options post]
      match '/export/patient', to: 'patients#export_patients', via: %i[options get]
      match '/import/diagnose', to: 'diagnose_paragraphs#import_diag', via: %i[options post]
      match '/import/patient', to: 'patients#import_patient', via: %i[options post]
      match '/preview/patients', to: 'patients#preview_data_patients', via: %i[options get]
      match '/update/icdo', to: 'cancer_informations#update_icdo', via: %i[options post]
      match '/check/editing', to: 'cancer_forms#check_editing', via: %i[options get]
      match '/change/editing/status', to: 'cancer_forms#change_editing_status', via: %i[options post]
      
      %i[
        case_types
        diagnose_paragraphs
        patients
        information_diagnoses
        cancer_forms
        treatment_informations
        import_patients
        treatment_follow_ups
        death_stats
        presents
        cancer_form_statuses
        search_icdos
        diagnose_informations
        cancer_informations
        bases
        topography_codes
        lateralities
        behaviors
        icdos
        grads
        metastasis_sites
        extents
        stage_others
        stages
        labs
        sexes
        post_codes
        address_codes
        marital_statuses
        races
        sub_districts
        districts
        provinces
        health_insurances
        religions
        users
        hospitals
        roles
      ].each do |res|
        match res.to_s, to: "#{res}#index", via: [:options]
        match "#{res}/new", to: "#{res}#new", via: %i[options get]
        match "#{res}/:id", to: "#{res}#show", via: [:options]
        resources res
      end
    end

  # Defines the root path route ("/")
  # root "posts#index"
end
