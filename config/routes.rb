Rails.application.routes.draw do

  namespace :admin do
    resources :audits, only: :show
    resources :usuarios do
      collection do
        get 'search'
        post 'datatable'
      end
    end
  end
  devise_for :usuarios, path: 'admin', path_names: { sign_in: 'entrar', sign_out: 'sair', password: 'alterar_senha' }
  match '500', :to => 'errors#internal_server_error', :via => :all
  match '422', :to => 'errors#unacceptable', :via => :all
  match '404', :to => 'errors#not_found', :via => :all
  get "admin", controller: :admin, action: :index, as: :admin_root
  RESPOND_404.map { |r2|  get "/#{r2}", to: redirect("/404") } 
  root "site#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
