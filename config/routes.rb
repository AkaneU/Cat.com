Rails.application.routes.draw do
  namespace :admin do
    get 'inquiries/show'
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'end_users/index'
    get 'end_users/show'
    get 'end_users/edit'
  end
  namespace :public do
    get 'inquiries/new'
    get 'inquiries/confirm'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/create'
    get 'posts/edit'
    get 'posts/show'
  end
  devise_for :end_users,skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  root :to => "public/homes#top"

  resources :end_users, module: :public

end
