Rails.application.routes.draw do
  root 'site#index'

  devise_for :users

  resources :user, only: [:show] do
    post :ban, to: :ban
  end

  resources :games do
    resources :ratings do
    end
    resources :reviews do
    end
  end

  resources :publishers, only: :show
  resources :developers, only: :show

  get 'stats', to: 'stats#stats', as: :stats

  get 'reviews/:id/upvote', to: 'votes#upvote', as: :upvote_review
  get 'reviews/:id/downvote', to: 'votes#downvote', as: :downvote_review

end
