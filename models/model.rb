require 'net/http'
require 'json'
require 'pp'

# url = 'https://api.teleport.org/api/cities/?search=Boston, New York, United States'
# uri = URI(url)
# response = Net::HTTP.get(uri)
# result = JSON.parse(response)
# pp result

# url = 'https://ridb.recreation.gov/api/activities'
# uri = URI(url)
# response = Net::HTTP.get(uri)
# result = JSON.parse(response)
# pp result
# value = ENV['API_KEY'], ENV['PASSWORD']
# value.authorization.access_token = '123'
# https://ridb.recreation.gov/docs#/Activities/getActivities

def get_population_data(city)
    general_url = 'https://api.teleport.org/api/cities/?search=' + city
    uri = URI(general_url)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    
    # access the link with population info
    population_link =  result["_embedded"]["city:search-results"][0]["_links"]["city:item"]["href"]
    population_uri = URI(population_link)
    response = Net::HTTP.get(population_uri)
    population_result = JSON.parse(response)
    pp population_result["population"]
end

def get_img(city)
    url = 'https://api.teleport.org/api/urban_areas/slug:' + city.gsub(/\s/, "-") + '/images/'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    pp result["photos"][0]["image"]["web"]
end

def get_city_description(city)
    url = 'https://api.teleport.org/api/urban_areas/slug:' + city.gsub(/\s/, "-") + '/scores/'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    info_string = result["summary"]
    pp info_string.split("    ")[1]
end

# get_city_info("boston")

# get_city_info

def quality_of_life_score
    url = 'https://api.teleport.org/api/urban_areas/slug:new-york/scores/'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    pp result["categories"]
end

quality_of_life_score

#circle_bar
# https://jsbin.com/yuquxucaga/edit?html,css,js,output

# https://jsbin.com/sujihejimo/edit?html,output

# how to use js in ruby
# https://stackoverflow.com/questions/15422497/how-to-use-javascript-variables-in-ruby