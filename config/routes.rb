# frozen_string_literal: true
Rails.application.routes.draw do
  root 'sessions#new'

  resources :events, except: :index
  resource  :session, only: %i[new create destroy]
  resources :users, only: %i[new create] do
    resources :events, only: :index
    resources :stats, only: :index
  end
end
