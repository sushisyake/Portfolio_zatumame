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

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to:"homes#top"
    # post 'customers/guest_sign_in', to: 'sessions#guest_sign_in'
    resources:genres, only: [:index, :show]
    resources:customers, only: [:edit, :index, :show] do
      resource :relationships, only: [:create, :destroy]
  	get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  	end
    resources:articles do
      resource:favorites, only: [:create, :destroy]
      resources :article_comments, only: [:create,:destroy]
    end
end

  namespace :admin do
    resources:genres, only: [:index, :show]
    resources:articles, only: [:index, :show]
    resources:customers, only: [:edit, :index, :show]
    end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
