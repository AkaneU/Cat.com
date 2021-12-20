Rails.application.routes.draw do

  devise_for :end_users,skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  root :to => "public/homes#top"

  namespace :admin do
   root :to => "homes#home"
  end

  namespace :admin do
    resources :end_users, only: [:index, :show, :edit, :update]
  end

  patch 'end_users/withdrawal' => "public/end_users#withdrawal", as: "withdrawal"
  get 'end_users/check' => "public/end_users#check", as: "check"
  scope module: :public do
    resources :end_users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => "relationships#followings", as: "followings"
      get 'followers' => "relationships#followers", as: "followers"
    end
  end


  get 'posts/popular' => "public/posts#this_week_popular", as: "popular"
  get 'posts/this_month_popular' => "public/posts#this_month_popular", as: "this_month_popular"
  get 'posts/last_month_popular' => "public/posts#last_month_popular", as: "last_month_popular"
  get 'posts/new_posts' => "public/posts#new_posts"
  get 'posts/timeline' => "public/posts#timeline", as: "timeline"
  get 'posts/favorited' => "public/posts#favorited"
  scope module: :public do
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end

  namespace :admin do
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
  end

  post 'inquiries/confirm' => "public/inquiries#confirm", as: "confirm"
  resources :inquiries, only: [:new, :create], module: :public

  namespace :admin do
    resources :inquiries, only: [:index, :show, :destroy]
  end

  resources :notifications, only: [:index], module: :public

end


