Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # tags and entities
      post '/tag', to: 'tags#create'
      get '/tags/:entity_type/:entity_id', to: 'tags#show'
      delete '/tags/:entity_type/:entity_id', to: 'tags#destroy'

      # stats
      get '/tags/stats', to: 'tags#stats'
      get '/tags/stats/:entity_type/:entity_id', to: 'tags#entity_stats'
    end
  end

end
