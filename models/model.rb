require 'net/http'
require 'json'
require 'pp'

# url = 'https://api.teleport.org/api/cities/?search=san%20francisco'
# uri = URI(url)
# response = Net::HTTP.get(uri)
# # pp JSON.parse(response)
# result = JSON.parse(response)
# pp result

def get_info(city_name)
    url = 'https://api.teleport.org/api/cities/?search=san%20francisco'
    url = URI(url)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    result
end

