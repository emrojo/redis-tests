require 'rest-client'

class Biomaterial

  def self.all
	site = RestClient::Resource.new("http://localhost:5000")
	site["materials"].get :content_type => 'text/json'  	
  end

  def self.find_by_id(id)
  	if id.match(/^[\d\w]*$/)
	  site = RestClient::Resource.new("http://localhost:5000")
	  site["materials"]["#{id}"].get :content_type => 'text/json'
	end
  rescue RestClient::NotFound => e
  	return nil
  end

  def self.create(params)
	site = RestClient::Resource.new("http://localhost:5000")
	site["materials"].post(params,  :content_type => 'text/json')
  end

  def delete
  	site = RestClient::Resource.new("http://localhost:5000")
  	site["materials"]["#{id}"].delete :content_type => 'text/json'
  end

  def update(params)
  	update_attributes!(params)
  end
end