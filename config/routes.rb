Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books do
        collection do
          get 'convert_isbn'
        end
      end

      resources :publishers
      resources :authors
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
