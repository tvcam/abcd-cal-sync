Rails.application.routes.draw do
  root 'home#index'

  delete :sign_out, to: 'sessions#destroy'
  get 'authorize', to: 'sessions#new'
  get 'google_sign_in/callback', to: 'sessions#callback'
end
