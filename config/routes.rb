Rails.application.routes.draw do
  mount EpiCas::Engine, at: '/'
  devise_for :users
  resources :group_cads
  resources :attachment_builds
  resources :group_builds
  resources :group_machines
  resources :attachment_machines
  resources :builds
  resources :machine_parameters
  resources :parameters
  resources :machines do
    get :parameters, on: :member
  end
  resources :build_projects
  resources :group_materials
  resources :materials
  resources :cads
  resources :group_users
  resources :attachments
  resources :groups
  resources :users
  resources :profile

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'cads/:id/download', to: 'cads#download', as: 'download_cad'

  get 'materials/:id/download/:attribute', to: 'materials#download', as: 'download_material' # Defines the root path route ("/")

  get 'builds/id/:id/download', to: 'builds#download', as: 'download_build'

  root 'pages#home'
end
