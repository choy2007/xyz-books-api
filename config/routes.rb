Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books, param: :isbn
      resources :publishers
      resources :authors

      get 'convert_isbn', to: 'books#convert_isbn'
    end
  end
end
