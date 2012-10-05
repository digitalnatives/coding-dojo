DiBm::Application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    resources :photos, only: [:index, :create, :show]
  end

end
