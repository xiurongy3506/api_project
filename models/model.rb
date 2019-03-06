require 'net/http'
require 'json'
require 'pp'

# url = 'https://api.teleport.org/api/cities/?search=Boston, New York, United States'
# uri = URI(url)
# response = Net::HTTP.get(uri)
# result = JSON.parse(response)
# pp result


# url = 'https://api.teleport.org/api/cities/?search=boston'
# uri = URI(url)
# response = Net::HTTP.get(uri)
# # pp JSON.parse(response)
# result = JSON.parse(response)
# # url is in str form
# pp result["_embedded"]["city:search-results"][0]["_links"]["city:item"]["href"]

# url = get_population_link
# uri = URI(url)
# response = Net::HTTP.get(uri)
# # pp JSON.parse(response)
# result = JSON.parse(response)
# # url is in str form
# pp result

# url = 'https://api.teleport.org/api/urban_areas/slug:new-york/images/'
# uri = URI(url)
# response = Net::HTTP.get(uri)
# # pp JSON.parse(response)
# result = JSON.parse(response)
# # url is in str form
# pp result ["photos"][0]["image"]["web"]

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
    result["population"]
end


def get_img(city_img)
    url = 'https://api.teleport.org/api/urban_areas/slug:' + city_img + '/images/'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    pp result["photos"][0]["image"]["web"]
end
