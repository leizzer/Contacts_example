Contacts::Application.routes.draw do
  resources :invitations

  resources :contacts


  root :to => "invitations#index"
end
