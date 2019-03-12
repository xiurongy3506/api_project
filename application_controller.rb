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
    @population = get_population_data(user_input_city)
    
    #Quality of Life scores
    @city_description = get_city_description(user_input_city)
    @commute_score = index(user_input_city)[0]["score_out_of_10"].round(1)
    @safety_score = index(user_input_city)[1]["score_out_of_10"].round(1)
    @healthcare_score = index(user_input_city)[2]["score_out_of_10"].round(1)
    @education_score = index(user_input_city)[3]["score_out_of_10"].round(1)
    @environment_score = index(user_input_city)[4]["score_out_of_10"].round(1)
    @economy_score = index(user_input_city)[5]["score_out_of_10"].round(1)
    @internet_score = index(user_input_city)[6]["score_out_of_10"].round(1)
    @tolerance_score = index(user_input_city)[7]["score_out_of_10"].round(1)
    erb :result
  end
  
end
