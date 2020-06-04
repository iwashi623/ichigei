Rails.application.routes.draw do
  devise_for :users, controllers: {
     sessions: 'public/sessions',
     registrations: 'public/registrations'
  }
  scope module: :public do
    get 'users/confirm', to: 'users#confirm'
    get 'users/withdraw', to: 'users#withdraw'
    resources :users, only: [:show, :edit, :update, :destroy, :index]
    resources :posts, only: [:show, :create, :destroy, :index] do
      resource :favorites, only: [:create, :destroy]
    end
    resources :works do
      resource :book_marks, only: [:create, :destroy]
    end
    resources :entries, only: [:show, :index, :create]
  end

  devise_for :admin, :controllers => {
     sessions: 'admin/sessions',
  }

  root 'home#home'
  get 'about', to: 'home#about'
  get 'contact', to: 'home#contact'
end
