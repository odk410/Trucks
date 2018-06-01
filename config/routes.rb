Rails.application.routes.draw do
  devise_for :users, controllers: {
       sessions: 'users/sessions'
     }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :celebrities
  resources :celeb_wikis do
    collection do
      get '/:celebrity_id/create' => 'celeb_wikis#new', as: :g
    end
  end
  resources :wiki_pic_uploads, only: [:create, :destroy]
  get 'transactions/account_inquiry'
  root 'home#index'

  resources :payments do
   member do
     put 'refund'
   end
   collection do
     get 'complete'
   end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# 404 error page 활성화
  # get '*path', controller: 'application', action: 'render_404'
end
