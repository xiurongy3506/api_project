require 'dotenv/load'
require 'bundler'
Bundler.require

require_relative 'models/model.rb'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index
  end
  
  post '/result' do
    
    # puts params
    user_input_city = params[:user_input_city]
    @user_city_img_url = get_img(user_input_city)
  
    # get_population_link(user_input_city)
    @population = get_population_data(user_input_city)
    
    @city_description = get_city_description(user_input_city)
    
    erb :result
  end
  
end
