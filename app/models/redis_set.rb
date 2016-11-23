class RedisSet < ActiveRecord::Base
  include Redis::Objects

  before_create :set_uuid

  def set_uuid
    self.uuid = SecureRandom.uuid
  end


  def add_member(uuid)
  	redis_object << uuid
  end

  def redis_object
  	Redis::Set.new(uuid)
  end

  def as_a_json
    @response = attributes
    @response[:members] = redis_object.to_a  	
    @response.to_json
  end

  def add_members(members)
  	redis_object.set(redis_object + members)
  end

end