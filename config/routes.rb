Rails.application.routes.draw do
  namespace :admin do
    resources :nature_of_reviews
  end
  resources :search, :only => [:index]
  get "/search/reviews" => "reviews#search_reviews", as: :search_reviews
  # mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, :controllers => {:registrations => "users/registrations",:sessions => "users/sessions", :confirmations => "users/confirmations"}
  root 'welcome#index'

  resources :admin, :only=>[:index]

  match 'searches' => 'admin#searches', via: [:get]
  resources :reviews do
	  resources :comments
  end
  match '/conversions'=> 'companies#conversions', as: :conversions, via: [:get, :post]
  match '/registered'=> 'companies#registered', as: :registered, via: [:get, :post]
  match '/unregistered'=> 'companies#unregistered', as: :unregistered, via: [:get, :post]
  match '/user-review'=> 'companies#user_review', as: :user_review, via: [:get, :post]
  match '/polls-bloopers'=> 'companies#polls_bloopers', as: :polls_bloopers, via: [:get, :post]

	get '/contact_us'=> 'contact_us#new', as: :contact_us

  resources :contact_us,:only => [:new, :create]
  resources :results
  resources :users,:only=>[:update,:edit]
  get '/resources/:slug' => 'resources#show', as: :resource


  match "/profile" => "users#show", via: [:get]
  match "/edit/profile" => "users#edit", via: [:get]
  match "/check_availiblity/user/preferred_alias"=> 'page#check_availiblity', via: [:get]
  get '/industry/companies_by_industry' => "reviews#companies_by_industry"
  get '/company/towns_by_company' => "reviews#towns_by_company"
  get '/town/locations_by_town_and_company' => "reviews#locations_by_town_and_company"
  get "/faqs" => "faqs#index",as: :faqs
  match "/:slug" => "pages#index",via: [:get],as: :page
  resources :polls ,:only => [:show]

  
  namespace :admin do
    resources :maintainences ,:only => [:index] do
      put "/toggle_status" => "maintainences#toggle_status"
    end

    put "/ticket_closed" => "reviews#ticket_closed"
    get "/searches/reviews" => "reviews#search_reviews", as: :search_reviews
    put '/assign_reviews'=> 'reviews#assign_reviews'
    get "change_password" => "users#change_password", as: :change_password
    put "update_password" => "users#update_password", as: :update_password

    get '/industry/companies_by_industry' => "reports#companies_by_industry"
    get '/company/towns_by_company' => "reports#towns_by_company"
    get '/town/locations_by_town_and_company' => "reports#locations_by_town_and_company"

    get '/total_reviews' => "reports#totalreviews"
    get '/nature_of_compliments' => "reports#nature_of_compliments"
    get '/nature_of_complaints2' => "reports#nature_of_complaints2"

    resources :monitor_jagents ,:only => [:index]
    resources :notifications ,:only => [:index]
    resources :customers ,:only => [:index]
  	resources :users
  	resources :locations
  	resources :towns
  	resources :companies
  	resources :industries
  	resources :nature_of_reviews
  	resources :reviews do
      resources :review_notes
      collection do 
        get :archive_reviews
        get :archive_files
      end
      put 'unpublished' => "reviews#unpublished"
  	  resources :comments do
        put 'unpublished_comment' => "comments#unpublished"
      end
  	end
  	#resources :addresses
    resources :contact_us, :only => [:index]
  	resources :polls
  	resources :faqs
  	resources :pages, :only => [:index, :edit, :update]
  	resources :resources
  	resources :agents
  	#resources :advertises
  	resources :suppliers
  	#resources :resource_types
    resources :seos
    #resources :company_performances
    #resources :abuse_reports
    
    
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
