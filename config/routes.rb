Rails.application.routes.draw do
  get 'grades/create'
  get 'grades/update'
  get 'grades/destroy'
  devise_for :users

  root "home#welcome"
  get "/top_commenters", to: "home#top_commenters", as: "top_commenters"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
    resources :comments, only: [:create, :destroy]
    resources :grades, only: [:create, :update, :destroy]
  end
end
