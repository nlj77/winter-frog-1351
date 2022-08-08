Rails.application.routes.draw do

  resources :plots, only: [:index]

  delete '/plots/:plot_id/plants/:plant_id', to: 'plot_plants#destroy'

  resources :gardens, only: [:show]

end
