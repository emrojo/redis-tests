require 'rest-client'

class Biomaterial

  def self.site
	RestClient::Resource.new(Rails.configuration.samples_service_url)
  end

  def self.all
	Biomaterial.site["materials"].get :content_type => 'text/json'  	
  end

  def self.find_by_id(id)
  	if id.match(/^[\d\w]*$/)
	  Biomaterial.site["materials"]["#{id}"].get :content_type => 'text/json'
	end
  rescue RestClient::NotFound => e
  	return nil
  end

  def self.create(params)
	Biomaterial.site["materials"].post(params,  :content_type => 'text/json')
  end

  def delete
  	Biomaterial.site["materials"]["#{id}"].delete :content_type => 'text/json'
  end

  def update(params)
  	update_attributes!(params)
  end
end