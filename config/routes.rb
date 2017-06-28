Ryohiseisan::Application.routes.draw do

  get "monthly_report/:employee_id(/:year/:month)", to: 'monthly_reports#show', as: :monthly_report
  get "monthly_reports", to: 'monthly_reports#index'
  resources :email, only: [:new, :create]
  resources :password, only: [:new, :create]

  resources :users, except: [ :show ] do
    member do
      get 'email'
      patch 'update_email'
      get 'password'
      patch 'update_password'
      get 'prefecture'
      patch 'update_prefecture'
    end
  end
  get 'activation/:activation_token' => 'users#activation', as: :activation

  resources :companies, except: [:show] do
    member do
      post 'change_daily_allowance'
    end

    resources :employees, except: [:show] do
      collection do
        get 'close'
      end

      resources :expense_templates, except: [:show] do
        member do
          get 'move/:move_type', to: 'expense_templates#move', as: :move
        end
      end
    end
    resources :daily_allowances
    resources :accommodation_charges
  end
  resources :schedules do
    resources :trip_expenses do
      member do
        get 'add_template'
      end
      collection do
        post 'merge_template'
      end
    end
  end

  post 'change_company' => "companies#change_company", as: :change_company
#  post 'resent_code' => 'companies#resent_code', as: :resent_code

  get 'email/:login_key/:activate_key' => 'email#activate', as: :email_activate

  get 'password/:login_key/:reset_code', to: 'password#edit', as: :reset_password
  get 'password', to: 'password#new'
  post 'password', to: 'password#create'
  put 'password', to: 'password#update'

  get 'signout' => "session#destroy", as: :signout
  post '/' => "session#create", as: :signin

  get 'menu' => 'session#menu', as: :menu

  get 'privacy_policy', to: 'web'
  get 'agreement', to: 'web'
  get 'operating_company', to: 'web'
  get 'legal', to: 'web'

  namespace 'rabbix' do
    resources :users, only: [ :index ] do
      member do
        get :edit_staff_restrict
        put :update_staff_restrict
        get :edit_expires
        put :update_expires
        put :update_user
      end
    end
    post 'users' => "users#index", as: :search

    get '/' => "users#index", as: :rabbix
    resources :daily_allowances
    resources :accommodation_charges
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'session#new'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
