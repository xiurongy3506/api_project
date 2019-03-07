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

def get_population_link
    url = 'https://api.teleport.org/api/cities/?search=boston'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    # pp JSON.parse(response)
    result = JSON.parse(response)
    # url is in str form
    result["_embedded"]["city:search-results"][0]["_links"]["city:item"]["href"]
end

def get_population_data
    url = get_population_link
    uri = URI(url)
    response = Net::HTTP.get(uri)
    # pp JSON.parse(response)
    result = JSON.parse(response)
    # url is in str form
    pp result["population"]
end


def get_img(city)
    url = 'https://api.teleport.org/api/urban_areas/slug:' + city + '/images/'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    pp result["photos"][0]["image"]["web"]
end

# def get_city_info
#     url = 'https://api.teleport.org/api/urban_areas/slug:' + city + '/scores/'
#     uri = URI(url)
#     response = Net::HTTP.get(uri)
#     result = JSON.parse(response)
#     pp result["summary"]
# end

# # def quality_of_life_score
#     url = 'https://api.teleport.org/api/urban_areas/slug:new-york/scores/'
#     uri = URI(url)
#     response = Net::HTTP.get(uri)
#     result = JSON.parse(response)
#     pp result
# end

# quality_of_life_score

# https://www.w3schools.com/w3css/tryit.asp?filename=tryw3css_progressbar_labels