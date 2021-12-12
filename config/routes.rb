Rails.application.routes.draw do
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
