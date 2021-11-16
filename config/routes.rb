Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :signals, only: [] do
    collection do
      get 'detect_peak'
    end
  end
end
