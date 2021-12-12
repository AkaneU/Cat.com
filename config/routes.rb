Rails.application.routes.draw do

  devise_for :end_users,skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  root :to => "public/homes#top"

  patch 'end_users/withdrawal' => "public/end_users#withdrawal", as: "withdrawal"
  get 'end_users/check' => "public/end_users#check", as: "check"

  resources :end_users, only: [:show, :edit, :update], module: :public

  resources :posts, module: :public

  resources :notifications, only: [:index], module: :public

end