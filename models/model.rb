require 'net/http'
require 'json'
require 'pp'

# url = 'https://api.teleport.org/api/cities/?search=Boston, New York, United States'
# uri = URI(url)
# response = Net::HTTP.get(uri)
# result = JSON.parse(response)
# pp result

# url = 'https://api.teleport.org/api/urban_areas/slug:new-york/images/'
# uri = URI(url)
# response = Net::HTTP.get(uri)
# # pp JSON.parse(response)
# result = JSON.parse(response)
# # url is in str form
# pp result
# # ["photos"][0]["image"]["web"]


    
# def get_info(city_name)
#     url = 'https://api.teleport.org/api/cities/?search=Boston, New York, United States'
#     uri = URI(url)
#     response = Net::HTTP.get(uri)
#     result = JSON.parse(response)
#     result
# end

def get_img(city_img)
    url = 'https://api.teleport.org/api/urban_areas/slug:new-york/images/'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    pp result["photos"][0]["image"]["web"]
end
