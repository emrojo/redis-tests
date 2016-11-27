class RedisSetsController < ApplicationController
  UUID_REGEXP = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i

  before_filter :validate_uuid?, only: [:update, :show, :destroy]

  def index
  	render :json => RedisSet.all.map(&:as_a_json)
  end

  def update
    @set = RedisSet.find(params[:id])

    @set.add_members(my_set_params[:members])

  	render :json => @set.as_a_json
  end

  def show
    @set = RedisSet.find(params[:id])

  	render :json => @set.as_a_json
  end

  def destroy
    @set = RedisSet.find(params[:id])
    @set.redis_object.clear
    @set.destroy

    render :json => true
  end

  def create
    @set = RedisSet.create!
    @set.redis_object.clear
    @set.add_members(my_set_params[:members])

    render :json => @set.as_a_json
  end

  private

  def validate_uuid?
    params[:id].match(UUID_REGEXP)
  end

  def my_set_params
    params.require(:redis_set).permit(:id, :members => [])
  end
end