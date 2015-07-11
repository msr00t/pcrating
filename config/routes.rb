Rails.application.routes.draw do
  root 'site#index'

  devise_for :users

  resources :user, only: [:show] do
    post :ban, to: :ban
  end

  resources :games do
    resources :ratings do
    end
  end

  get 'reviews/:id/upvote', to: 'votes#upvote', as: :upvote_rating
  get 'reviews/:id/downvote', to: 'votes#downvote', as: :downvote_rating

end
