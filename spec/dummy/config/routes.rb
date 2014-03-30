Rails.application.routes.draw do

  root "home#index"
  get 'foo', to: 'home#foo'
  devise_for :user, controllers:  {registrations: "registrations"}

end
