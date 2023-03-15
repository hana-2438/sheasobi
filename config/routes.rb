Rails.application.routes.draw do

  # 管理者用
# URL /admin/sign_in ...
devise_for :admin,  skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 # 顧客用
 # URL /members/sign_in ...
devise_for :members, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'


}
  devise_scope :member do
    post 'guest_sign_in', to: 'public/sessions#guest_sign_in'
  end





  namespace :admin do
    get '/' => 'homes#top'
    resources :members, only: [:index,:edit,:update]
    resources :tags, only: [:index,:create,:edit,:update, :destroy]
  end

  scope module: :public do
    root to: "homes#top"
    get 'members/confirm' => 'members#confirm',as:'members_confirm'
    resources :members, only: [:show,:edit,:update,:destroy] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      member do
       get 'favorites'
      end

    end

    patch 'members/:id/withdraw' => 'members#withdraw', as: 'members_withdraw'

    resources :posts, only: [:new,:create,:show,:edit,:update,:index,:destroy] do
      resources :post_comments, only: [:create,:destroy]
      resource :favorites, only: [:create,:destroy]
    end
    get '/searches' => 'searches#search', as:'search'
  end



end
