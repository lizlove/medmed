class PillboxWrapper

  PB_KEY = ENV["pillbox_key"]

  def self.request(rxcui)
    binding.pry
    base_url = "http://pillbox.nlm.nih.gov/PHP/pillboxAPIService.php?key=" + PB_KEY
    binding.pry
    search_url = "&rxcui=" 
    total_url = base_url + search_url + rxcui
    api_request = URI(URI.encode(total_url))
    @api_response = Net::HTTP.get(api_request) 
    JSON.parse(@api_response)
  end

  # def self.image
      #XML image_id
  #   result = self.request(self.perscriptions.medication_id)
  #   result.collect do |side_affects|
  #     location["geometry"]["location"]["lat"],location["geometry"]["location"]["lng"],4)
  #   end
  # end

  # def image_call
  #   if results["image_id"] = nil 

  #   %3cimage_id%3e
  # end 

  # def get_image_uri
  #   base_uri = "http://pillbox.nlm.nih.gov/assets/small/" + @image_id + ".jpg"

  # end 

end