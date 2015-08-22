Rails.application.routes.draw do
  root 'site#index'

  devise_for :users

  resources :user, only: [:show] do
    post 'report', to: 'user#report', as: 'report'
  end

  namespace :admin do
    post 'users/:id/restore',   to: 'users#restore', as: :restore_user
    post 'reviews/:id/restore', to: 'reviews#restore', as: :restore_review
    post 'reviews/:id/destroy', to: 'reviews#destroy', as: :destroy_review
  end

  namespace :mod do
    resources :dashboard, only: :index

    get    'reviews/deleted/:page', to: 'reviews#deleted', as: :deleted_reviews
    delete 'reviews/:id/destroy',   to: 'reviews#destroy', as: :destroy_review

    get 'users/banned/:page',    to: 'users#banned',    as: :banned_users
    post 'users/:id/ban',        to: 'users#ban',       as: :ban_user

    get  'reports/users/:page',   to: 'reports#users',   as: :user_reports
    get  'reports/reviews/:page', to: 'reports#reviews', as: :review_reports
    post 'reports/:id/reject',    to: 'reports#reject', as: :reject_report
  end

  resources :games do
    resources :reviews do
      post 'report', to: 'reviews#report', as: 'report'
    end
  end

  resources :publishers, only: :show
  resources :developers, only: :show

  get 'reviews/:id/upvote', to: 'votes#upvote', as: :upvote_review
  get 'reviews/:id/downvote', to: 'votes#downvote', as: :downvote_review

end
