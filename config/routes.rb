Rails.application.routes.draw do

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
  	  member do
        get :favorites
      end
  	end
    resources:articles do
      resource:favorites, only: [:create, :destroy]
      resource:unfavorites, only: [:create, :destroy]
      resources :article_comments, only: [:create,:destroy]
    end
    get "users/confirm/:id"=>"users#confirm", as: :confirm
    patch "users/exit/:id"=>"users#exit", as: :exit
    get "search" => "searches#search"
end

  namespace :admin do
    root to:'homes#top'
    resources:users, only: [:edit, :index, :update]
    resources:genres, only: [:index, :create, :edit, :update]
    resources:articles, only: [:index, :show, :edit] do
      resources :article_comments, only: [:create,:destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
