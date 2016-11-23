class RedisSetsController < ApplicationController

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

  def my_set_params
    params.require(:redis_set).permit(:id, :members => [])
  end
end