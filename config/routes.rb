Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # tags and entities
      post '/tag', to: 'tags#create'
      get '/:entity_type/:entity_id', to: 'tags#get'
      delete '/:entity_type/:entity_id', to: 'tags#destroy'

      # stats
      get '/stats', to: 'tags#stats'
      get '/stats/:entity_type/:entity_id', to: 'tags#entity_stats'
    end
  end

end
