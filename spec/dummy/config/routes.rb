Rails.application.routes.draw do

  root "home#index"
  devise_for :user, controllers:  {registrations: "registrations"}

end
