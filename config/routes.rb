Rails.application.routes.draw do
  get 'status' => 'status#index'
  post '/parties' => 'parties#create'
end
