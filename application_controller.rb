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
    
    @city_full_name = get_city_name(user_input_city)
    # get_population_link(user_input_city)
    get_state_abbreviation
    @population = get_population_data(user_input_city)
    
    #Quality of Life scores
    @city_description = get_city_description(user_input_city)
    @commute_score = commute(user_input_city)
    @safety_score = safety(user_input_city)
    @healthcare_score = healthcare(user_input_city)
    @education_score = education(user_input_city)
    @environment_score = environment(user_input_city)
    @economy_score = economy(user_input_city)
    @internet_score = internet(user_input_city)
    @tolerance_score = tolerance(user_input_city)
    
    #recreation data
    @recreation_name = recreation_api[0]
    @recreation_description = recreation_api[1]
    @recreation_direction = recreation_api[2]
    @recreation_contact = recreation_api[3]
    erb :result
  end
  
end
