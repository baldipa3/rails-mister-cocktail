Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "cocktails#index"

  resources :cocktails, except: [:index] do
    resources :doses, except: [:destroy]
  end

  delete "doses/:id", to: "doses#destroy", as: :dose
end
