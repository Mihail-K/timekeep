# frozen_string_literal: true
Rails.application.routes.draw do
  resources :events
  resource  :session, only: %i[new create destroy]
  resources :users, only: %i[new create]
end
