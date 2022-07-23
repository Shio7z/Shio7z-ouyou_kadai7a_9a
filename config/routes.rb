Rails.application.routes.draw do

  get 'viewcounts/create'
 
  devise_for :users
  root to: "homes#top"
  get '/abouts' => "homes#about", as: 'abouts'
  
  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :chats, only: [:create, :show]
  resources :view_counts, only: [:create]
 
end