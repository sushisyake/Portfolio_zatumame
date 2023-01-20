Rails.application.routes.draw do


  namespace :admin do
    get 'homes/top'
  end
  namespace :admin do
    get 'user/index'
    get 'user/show'
  end
# 顧客用
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to:"homes#top"
    resources:genres, only: [:index, :show]
    resources:users, only: [:index, :show, :update] do
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
    root to:'homes#top'
    resources:genres, only: [:index, :show]
    resources:articles, only: [:index, :show, :edit] do
      resources :article_comments, only: [:create,:destroy]
    end
    resources:users, only: [:edit, :index, :show]

    end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
