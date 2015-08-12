class Medication
  
  def self.dropdown_hash(search_term)
    json = json_from_api("https://rxnav.nlm.nih.gov/REST/drugs?name=#{search_term}")
    drug_hash = {}
    if json['rxnormdata']['drugGroup']['conceptGroup']
      json['rxnormdata']['drugGroup']['conceptGroup'].each do |conceptGroup|
        if conceptGroup['conceptProperties']
          conceptGroup['conceptProperties'].each do |drug|
            key = drug['synonym'] ? drug['synonym'] : drug['name']
            value = drug['rxcui']
            drug_hash[key] = value
          end
        end
      end
    end
    drug_hash
  end

  def self.find_name_by_rxcui(rxcui)
    json = json_from_api("https://rxnav.nlm.nih.gov/REST/rxcui/#{rxcui}/properties")
    if json['rxnormdata']['properties']
      drug = json['rxnormdata']['properties']
      drug['synonym'] ? drug['synonym'] : drug['name']
    end
  end

  private

  def self.json_from_api(url)
    xml = RestClient.get(url)
    Crack::XML.parse(xml)
  end
end
