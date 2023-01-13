Rails.application.routes.draw do


# 顧客用
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    root to:"homes#top"
    resources:genres, only: [:index, :show]
    resources:articles, only: [:index, :show]
    resources:customers, only: [:index, :show]
end

  namespace :admin do
    resources:genres, only: [:index, :show]
    resources:articles, only: [:index, :show]
    resources:customers, only: [:index, :show]
    end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
