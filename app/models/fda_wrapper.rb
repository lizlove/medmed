class FdaWrapper

  FDA_KEY = ENV["fda_key"]

  def self.request(rxcui)
    base_url = "https://api.fda.gov/drug/label.json?api_key=" + FDA_KEY + "&search=rxcui:" 
    api_request = base_url + rxcui
    binding.pry
    api_response = open(api_request).read
    JSON.parse(api_response)["results"]
  end

end


