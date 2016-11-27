
class RedisSet < ActiveRecord::Base
  include Redis::Objects

  before_create :set_uuid

  def set_uuid
    self.uuid = SecureRandom.uuid
  end


  def add_member(uuid)
    return false unless valid_members?([uuid])
  	redis_object << uuid
  end

  def redis_object
  	Redis::Set.new(uuid)
  end

  def current_members
    redis_object.to_a.each do |id|
      Biomaterial.find_by_id(id)
    end
  end

  def as_a_json
    @response = attributes
    @response[:members] = current_members
    @response
  end

  def add_members(members)
    return false unless valid_members?(members)
    redis_object.merge(members)
    #redis_object.set(self.uuid, redis_object + members)
    true
  end

  def valid_members?(members)
    !members.any?{|m| Biomaterial.find_by_id(m).nil?}
  end

end