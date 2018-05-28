Rails.application.routes.draw do
  devise_for :users
  resources :celebrities
  resources :celeb_wikis do
    collection do
      get '/:celebrity_id/create' => 'celeb_wikis#new', as: :g
    end
  end
  resources :wiki_pic_uploads, only: [:create, :destroy]
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
