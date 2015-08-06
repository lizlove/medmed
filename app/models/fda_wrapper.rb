class FdaWrapper

  FDA_KEY = ENV['fda_key']

  def self.request(rxcui)
    base_url = "https://api.fda.gov/drug/label.json?" + "search=rxcui:" 
    api_request = URI(URI.encode(base_url + rxcui))
    api_response = Net::HTTP.get(api_request)
    JSON.parse(api_response)["results"][0]["spl_medguide"][0]
  end

end
