DiBm::Application.routes.draw do

  scope 'api', module: :api, defaults: {format: 'json'} do
    resources :photos, only: [:index, :create, :show]
  end

end
