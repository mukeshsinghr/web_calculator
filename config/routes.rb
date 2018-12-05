Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root to: 'api/v1/calculator#index' 
#, "api/v1/calculator#index"
# root :to => "api/v1/users#home"

namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
    	post 'calculator/perform_calculation'
    	#, to: 'calculator#perform_calculation'
	end
end


end
