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
    user_activities = params[:user_activities]
    user_input_city = params[:user_input_city]
    @user_city_img_url = get_img(user_input_city)
    
    @city_full_name = get_city_name(user_input_city)
    # get_population_link(user_input_city)
    get_state_abbreviation
    @population = get_population_data(user_input_city)
    @city_description = get_city_description(user_input_city)
    
    @activity_name = get_activity_name(user_activities)
    
    #Quality of Life scores
    @commute_score = score(user_input_city)[0]
    @safety_score = score(user_input_city)[1]
    @healthcare_score = score(user_input_city)[2]
    @education_score = score(user_input_city)[3]
    @environment_score = score(user_input_city)[4]
    @economy_score = score(user_input_city)[5]
    @internet_score = score(user_input_city)[6]
    @tolerance_score = score(user_input_city)[7]
    
    #recreation data
    @recreation_name = recreation_api[0]
    @recreation_description = recreation_api[1]
    @recreation_direction = recreation_api[2]
    @recreation_contact = recreation_api[3]
    erb :result
  end
  
end
