Rails.application.routes.draw do
  resources :case_types
  resources :diagnose_paragraphs
  resources :patients
  resources :information_diagnoses
  resources :cancer_forms
  resources :treatment_informations
  resources :import_patients
  resources :treatment_follow_ups
  resources :death_stats
  resources :presents
  resources :cancer_form_statuses
  resources :search_icdos
  resources :diagnose_informations
  resources :cancer_informations
  resources :bases
  resources :topography_codes
  resources :lateralities
  resources :behaviors
  resources :icdos
  resources :grads
  resources :metastasis_sites
  resources :extents
  resources :stage_others
  resources :stages
  resources :labs
  resources :sexes
  resources :post_codes
  resources :address_codes
  resources :marital_statuses
  resources :races
  resources :sub_districts
  resources :districts
  resources :provinces
  resources :health_insurances
  resources :religions
  resources :users
  resources :hospitals
  resources :roles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
