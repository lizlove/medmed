class Medication
  def self.dropdown_name_list(search_term)
    xml = RestClient.get("https://rxnav.nlm.nih.gov/REST/drugs?name=#{search_term}")
    json = Crack::XML.parse(xml)
    if json['rxnormdata']['drugGroup']['conceptGroup']
      json['rxnormdata']['drugGroup']['conceptGroup'].map do |conceptGroup|
        if conceptGroup['conceptProperties']
          conceptGroup['conceptProperties'].map do |drug|
            drug['synonym'] ? drug['synonym'] : drug['name']
          end
        end
      end.flatten.compact
    else
      []
    end
  end
  def self.dropdown_hash(search_term)
    xml = RestClient.get("https://rxnav.nlm.nih.gov/REST/drugs?name=#{search_term}")
    json = Crack::XML.parse(xml)
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
end
