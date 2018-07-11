Rails.application.routes.draw do
  namespace :api do  namespace :v1 do resources :supports, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :favorite_spots, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :devices, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :alerts, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :notifications, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :spot_estimates, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :report_image_comments, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :report_image_likes, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :report_images, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :report_likes, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :report_comments, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :reports, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :spots, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :followings, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :followers, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :sports, except: [:new, :edit] end end
  namespace :api do
  namespace :v1 do
    post 'auth/token'
    post 'users/password_refresh'
    post 'sport_user' => 'sport_user#create'
    put  'profile' => 'profile#update'
    put  'users/:id/settings' => 'users#settings'
    get  'messages/:id/recepient' => 'messages#recepient'
    get  'city/:input' => 'city#autocomplete'
    get  'geo' => 'geo#complete'
    get  'reports/:id/comments' => 'report_comments#comments'
    get  'reports/:id/likes' => 'report_likes#likes'
    get  'reports/:id/images' => 'report_images#images'
    get  'users/:id/images' => 'report_images#uimages'
    get  'report_images/:id/likes' => 'report_image_likes#likes'
    get  'report_images/:id/comments' => 'report_image_comments#comments'
    get  'forecast/gfs' => 'forecast#gfs'
    get  'posts' => 'reports#posts'
    get  'feed/:user_id' => 'reports#feed'
    get  'spots/:id/feed' => 'spots#feed'
    get  'sensors/in/:slug' => 'sensors#in'
    get  'sensors/get/:slug' => 'sensors#get'
    get  'sensors/nearest/:spot' => 'sensors#nearest'
    get  'pages/terms' => 'pages#terms'
    get  'pages/privacy' => 'pages#privacy'
    delete 'sport_user/:sport_id' => 'sport_user#destroy'
    delete 'spots/unsubscribe/:id' => 'spots#unsubscribe'

    get  'conversations' => 'conversations#index'
    get  'messages/:user_id/recipient' => 'conversations#recipient'
    get  'conversations/:conversation_id/messages' => 'messages#index'
    post 'conversations' => 'conversations#create'
    post 'conversations/:conversation_id/messages' => 'messages#create'

    get  'support/status' => 'supports#status'
    end
  end

  namespace :api do  namespace :v1 do resources :users, except: [:new, :edit] end end
  namespace :api do  namespace :v1 do resources :messages, except: [:new, :edit] end end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
