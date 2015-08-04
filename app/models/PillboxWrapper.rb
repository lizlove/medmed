class PillboxWrapper

  PB_KEY = ENV["pillbox_key"]

  def self.request(request_url)
    base_url = "http://pillbox.nlm.nih.gov/PHP/pillboxAPIService.php?key=" + PB_KEY
    search_url = "&rxcui=" 
    api_request = base_url + search_url + request_url
    api_response = open(api_request).read
    JSON.parse(api_response)["results"]
  end

  # def self.image
      #XML image_id
  #   result = self.request(self.perscriptions.medication_id)
  #   result.collect do |side_affects|
  #     location["geometry"]["location"]["lat"],location["geometry"]["location"]["lng"],4)
  #   end
  # end


end