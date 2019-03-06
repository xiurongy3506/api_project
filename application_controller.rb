require 'dotenv/load'
require 'bundler'
Bundler.require

require_relative 'models/model.rb'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index
  end
  
  post '/result' do
    
    puts params
    user_input_city = params[:user_input_city]
    @user_city_img_url = get_img(user_input_city)
    
    # put this info in once Johnson finishes working on html and css/ to avoid merge conflict
    @population = get_population_data
    
    erb :result
  end
  
end
