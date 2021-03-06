Rails.application.routes.draw do
  root "groups#index"

  resources :groups, except: [:edit, :update] do
    member do
      get 'invite'
      post 'invite', to: 'groups#send_invites'
      get 'join'
    end
  end

  resources :salaries, only: [:new, :create, :update, :destroy]

  resources :users, only: [:new, :create] do
    member do
      get 'verification'
      get 'resend_verification'
      get 'verify'
      get 'settings'
    end
  end

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  scope '/graphs' do
    controller :graphs do
      get ':group_id/distribution(/:title)' => :distribution, as: 'distribution_graph'
      get ':group_id/scatter(/:title)' => :scatter, as: 'scatter_graph'
      get ':group_id/title-medians' => :title_medians, as: 'title_medians_graph'
    end
  end
end
