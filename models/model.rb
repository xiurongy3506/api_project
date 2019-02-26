require 'net/http'
require 'json'
require 'pp'

# url = 'https://api.teleport.org/api/urban_areas/slug:san-francisco-bay-area/images/'
# uri = URI(url)
# response = Net::HTTP.get(uri)
# # pp JSON.parse(response)
# result = JSON.parse(response)
# puts result["photos"]

def get_info(city_name)
    url = 'https://api.teleport.org/api/urban_areas/slug:san-francisco-bay-area/images/'
    url = URI(url)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    result["photos"]
end

