Rails.application.routes.draw do
  resources :listings

  # devise_for :users
  #page#indexを何もないURLを指定した場合に表示するベージ(root)に設定する
  root 'pages#index'
  #root :to => 'pages#index'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users , only:[:show]
  resources :photos, only:[:create, :destroy] do
    collection do
      get :list
    end
  end

  get 'manage-listing/:id/basics' => 'listings#basics', as: 'manage-listing_basics'
  get 'manage-listing/:id/description' => 'listings#description', as: 'manage_listing_description'

  get 'manage-listing/:id/adress' => 'listings#adress', as: 'manage_listing_adress'
  get 'manage-listing/:id/price' => 'listings#price', as: 'manage_listing_price'
  get 'manage-listing/:id/photos' => 'listings#photos', as: 'manage_listing_photos'
  get 'manage-listing/:id/calendar' => 'listings#calendar', as: 'manage_listing_calendar'
  get 'manage-listing/:id/bankaccount' => 'listings#bankaccount', as: 'manage_listing_bankaccount'
  get 'manage-listing/:id/publish' => 'listings#publish', as: 'manage_listing_publish'
end
