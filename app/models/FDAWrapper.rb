class FdaWrapper

  GP_KEY = ENV["fda_key"]

  def self.request(request_url)
    base_url = "https://api.fda.gov/drug/label.json?"
    api_url = "api_key=" + GP_KEY
    search_url = "search=openfda.rxcui:"
    api_request = base_url + api_url + search_url + request_url
    api_response = open(api_request).read
    JSON.parse(api_response)["results"]
  end

  def self.all
    result = self.request(self.perscriptions.medication_id)
    hospital = Struct.new(:latitude, :longitude, :weight)
    result.collect do |location|
      hospital.new(location["geometry"]["location"]["lat"],location["geometry"]["location"]["lng"],4)
    end
  end

  # @@all = self.all

end