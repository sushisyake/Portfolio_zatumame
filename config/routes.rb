Rails.application.routes.draw do


  namespace :public do
    get 'favorites/create'
    get 'favorites/destroy'
  end
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
    resources:articles, only: [:index, :show, :new, :create]
    resources:customers, only: [:edit, :index, :show] do
      resource :relationships, only: [:create, :destroy]
  	get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  	end
  end
    resources:articles, only: [:index, :show, :new, :create] do
      resource:favorites, only: [:create, :destroy]
    end
    resources:customers, only: [:index, :show]
end

  namespace :admin do
    resources:genres, only: [:index, :show]
    resources:articles, only: [:index, :show]
    resources:customers, only: [:edit, :index, :show]
    end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
