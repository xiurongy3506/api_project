require 'net/http'
require 'json'
require 'pp'
require 'dotenv/load'

def get_city_name(city)
    begin
    if city == "san francisco bay area"
        url_name = "san francisco"
        general_url = 'https://api.teleport.org/api/cities/?search=' + url_name
        uri = URI(general_url)
    else
        general_url = 'https://api.teleport.org/api/cities/?search=' + city
        uri = URI(general_url)
    end
    
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    
    @city_name = result["_embedded"]["city:search-results"][0]["matching_full_name"]
    rescue
        result = ["Sorry, city not found"]
    end

end
# get_city_name("new york")

def get_state_abbreviation
    begin
    state = {
      'AL' => 'Alabama',
      'AK' => 'Alaska',
      'AS' => 'America Samoa',
      'AZ' => 'Arizona',
      'AR' => 'Arkansas',
      'CA' => 'California',
      'CO' => 'Colorado',
      'CT' => 'Connecticut',
      'DE' => 'Delaware',
      'DC' => 'District of Columbia',
      'FM' => 'Micronesia1',
      'FL' => 'Florida',
      'GA' => 'Georgia',
      'GU' => 'Guam',
      'HI' => 'Hawaii',
      'ID' => 'Idaho',
      'IL' => 'Illinois',
      'IN' => 'Indiana',
      'IA' => 'Iowa',
      'KS' => 'Kansas',
      'KY' => 'Kentucky',
      'LA' => 'Louisiana',
      'ME' => 'Maine',
      'MH' => 'Islands1',
      'MD' => 'Maryland',
      'MA' => 'Massachusetts',
      'MI' => 'Michigan',
      'MN' => 'Minnesota',
      'MS' => 'Mississippi',
      'MO' => 'Missouri',
      'MT' => 'Montana',
      'NE' => 'Nebraska',
      'NV' => 'Nevada',
      'NH' => 'New Hampshire',
      'NJ' => 'New Jersey',
      'NM' => 'New Mexico',
      'NY' => 'New York',
      'NC' => 'North Carolina',
      'ND' => 'North Dakota',
      'OH' => 'Ohio',
      'OK' => 'Oklahoma',
      'OR' => 'Oregon',
      'PW' => 'Palau',
      'PA' => 'Pennsylvania',
      'PR' => 'Puerto Rico',
      'RI' => 'Rhode Island',
      'SC' => 'South Carolina',
      'SD' => 'South Dakota',
      'TN' => 'Tennessee',
      'TX' => 'Texas',
      'UT' => 'Utah',
      'VT' => 'Vermont',
      'VI' => 'Virgin Island',
      'VA' => 'Virginia',
      'WA' => 'Washington',
      'WV' => 'West Virginia',
      'WI' => 'Wisconsin',
      'WY' => 'Wyoming'
    }
    
    state.each do |abbreviation, full_name|
        if (@city_name.split(", ")[0].upcase == state[abbreviation].upcase) || (@city_name.split(", ")[1].upcase == state[abbreviation].upcase)
            pp  @state = abbreviation
        end
    end
    rescue
        @state = ["Sorry, city not found"]
    end

end
# get_state_abbreviation

def recreation_api
    begin
    link = "https://ridb.recreation.gov/api/v1/recareas?limit=50&offset=0&state=" + @state + "&activity=BIKING&lastupdated=10-01-2018"
    uri = URI.parse(link)
    request = Net::HTTP::Get.new(uri)
    request["Accept"] = "application/json"
    request["Apikey"] = ENV['API_KEY']

    req_options = {
    use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
    end

    recreation_data = response.body
    hash = eval(recreation_data)
    
    recreation_data = []
    # grabs site name
    recreation_data << hash[:RECDATA][0][:RecAreaName]
    # grabs site description
    recreation_data << hash[:RECDATA][0][:RecAreaDescription]
    # direction
    recreation_data << hash[:RECDATA][0][:RecAreaDirections]
    # contact
    recreation_data << hash[:RECDATA][0][:RecAreaPhone]
    rescue
        hash = ["Sorry, city not found"]
    end
    # get the state abbreviation by the user input
end
# pp recreation_api[0]

def get_population_data(city)
    begin
        if city == "san francisco bay area"
            url_name = "san francisco"
            general_url = 'https://api.teleport.org/api/cities/?search=' + url_name
            uri = URI(general_url)
        else
            general_url = 'https://api.teleport.org/api/cities/?search=' + city.downcase
            uri = URI(general_url)
        end
    
        uri = URI(general_url)
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
    
        # access the link with population info
        population_link =  result["_embedded"]["city:search-results"][0]["_links"]["city:item"]["href"]
        population_uri = URI(population_link)
        response = Net::HTTP.get(population_uri)
        population_result = JSON.parse(response)
        population_result["population"]
        rescue
            result = ["Sorry, city not found"]
        end
end

# get_population_data("boston")

def get_img(city)
    begin
        # make what user type match the img name
        if city == "san francisco"
        img_name = "san francisco bay area"
        url = 'https://api.teleport.org/api/urban_areas/slug:' + img_name.gsub(/\s/, "-") + '/images/'
        else
        url = 'https://api.teleport.org/api/urban_areas/slug:' + city.downcase.gsub(/\s/, "-") + '/images/'
        end
    
        uri = URI(url)
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
        pp result["photos"][0]["image"]["web"]
    rescue
        result = ["Sorry, city not found"]
    end
end

def get_city_description(city)
    begin
        url = 'https://api.teleport.org/api/urban_areas/slug:' + city.downcase.gsub(/\s/, "-") + '/scores/'
        uri = URI(url)
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
        result["summary"].split(/\n+/)[0..-2].join
        # info_string.split("")[1]
        # pp info_string
    rescue
        result = ["Sorry, city not found"]
    end
end
# puts get_city_description("boston")




def commute(city)
    begin
        url = 'https://api.teleport.org/api/urban_areas/slug:' + city.downcase.gsub(/\s/, "-") + '/scores/'
        uri = URI(url)
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
    
        # elements = []
        #boston
        # 0. add commute 4.4
        pp result["categories"][5]["score_out_of_10"].round(1)
        
        # 1. add safety 7.7
        elements << result["categories"][7]
        # 2. add healthcare 9.0
        elements << result["categories"][8]
        # 3. add Education 8.6
        elements << result["categories"][9]
        # 4. add Environmental Quality 8.2
        elements << result["categories"][10]
        # 5. add Economy 6.5
        elements << result["categories"][11]
        # 6. add Internet access 5.7
        elements << result["categories"][13]
        # 7. add Toloerance 8.5
        elements << result["categories"][15]
    rescue
        result = ["Sorry, city not found"]
    end
    # pp result["categories"]
    # pp elements
end





def commute(city)
    begin
        url = 'https://api.teleport.org/api/urban_areas/slug:' + city.downcase.gsub(/\s/, "-") + '/scores/'
        uri = URI(url)
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
    
        # elements = []
        #boston
        # 0. add commute 4.4
        pp result["categories"][5]["score_out_of_10"].round(1)
    rescue
        result = ["Sorry, city not found"]
    end
end

def safety(city)
    begin
        url = 'https://api.teleport.org/api/urban_areas/slug:' + city.downcase.gsub(/\s/, "-") + '/scores/'
        uri = URI(url)
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
    
        # elements = []
        #boston
        # 0. add commute 4.4
        pp result["categories"][7]["score_out_of_10"].round(1)
    rescue
        result = ["Sorry, city not found"]
    end
end

def healthcare(city)
    begin
        url = 'https://api.teleport.org/api/urban_areas/slug:' + city.downcase.gsub(/\s/, "-") + '/scores/'
        uri = URI(url)
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
    
        # elements = []
        #boston
        # 0. add commute 4.4
        pp result["categories"][8]["score_out_of_10"].round(1)
    rescue
        result = ["Sorry, city not found"]
    end
end

def education(city)
    begin
        url = 'https://api.teleport.org/api/urban_areas/slug:' + city.downcase.gsub(/\s/, "-") + '/scores/'
        uri = URI(url)
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
    
        # elements = []
        #boston
        # 0. add commute 4.4
        pp result["categories"][9]["score_out_of_10"].round(1)
    rescue
        result = ["Sorry, city not found"]
    end
end

def environment(city)
    begin
        url = 'https://api.teleport.org/api/urban_areas/slug:' + city.downcase.gsub(/\s/, "-") + '/scores/'
        uri = URI(url)
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
    
        # elements = []
        #boston
        # 0. add commute 4.4
        pp result["categories"][10]["score_out_of_10"].round(1)
    rescue
        result = ["Sorry, city not found"]
    end
end

def economy(city)
    begin
        url = 'https://api.teleport.org/api/urban_areas/slug:' + city.downcase.gsub(/\s/, "-") + '/scores/'
        uri = URI(url)
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
    
        # elements = []
        #boston
        # 0. add commute 4.4
        pp result["categories"][11]["score_out_of_10"].round(1)
    rescue
        result = ["Sorry, city not found"]
    end
end

def internet(city)
    begin
        url = 'https://api.teleport.org/api/urban_areas/slug:' + city.downcase.gsub(/\s/, "-") + '/scores/'
        uri = URI(url)
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
    
        # elements = []
        #boston
        # 0. add commute 4.4
        pp result["categories"][13]["score_out_of_10"].round(1)
    rescue
        result = ["Sorry, city not found"]
    end
end

def tolerance(city)
    begin
        url = 'https://api.teleport.org/api/urban_areas/slug:' + city.downcase.gsub(/\s/, "-") + '/scores/'
        uri = URI(url)
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
    
        # elements = []
        #boston
        # 0. add commute 4.4
        pp result["categories"][15]["score_out_of_10"].round(1)
    rescue
        result = ["Sorry, city not found"]
    end
end


# pp index('boston')[2]["score_out_of_10"].round(1)
# pp index('boston')[3]["score_out_of_10"].round(1)
# pp index('boston')[7]["score_out_of_10"].round(1)
# index('boston')