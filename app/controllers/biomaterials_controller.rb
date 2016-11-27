class BiomaterialsController < ApplicationController
	
  def index
  	@biomaterials = Biomaterial.all

  	render :json => @biomaterials
  end

  def update
  	@biomaterial = Biomaterial.find_by_id(params[:id]).update(biomaterial_params)

  	render :json => @biomaterial  	
  end

  def create
  	@biomaterial = Biomaterial.create(biomaterial_params)

  	render :json => @biomaterial
  end

  def show
  	@biomaterial = Biomaterial.find_by_id(params[:id])

  	render :json => @biomaterial
  end

  def biomaterial_params
  	params.require(:biomaterial).permit!
  end

end