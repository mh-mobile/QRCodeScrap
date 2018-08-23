Rails.application.routes.draw do

  namespace :api, format: 'json' do
    namespace :v1 do
      post '/login', to: 'session#create'
      post '/signup', to: 'users#create'
      post '/api_token_validate', to: 'session#validate_api_token'
      post '/qrcode', to: 'qrcodes#create'
      get '/qrcodes', to: 'qrcodes#list'
      get '/my/qrcode', to: 'my_qrcodes#list'
    end
  end

end
