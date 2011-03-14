HmtExample::Application.routes.draw do
  
  resources :patients, :physicians do 
    resources :appointments
  end
  
  root :to => "physicians#index"
  
end
