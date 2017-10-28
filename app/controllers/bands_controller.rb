class BandsController < ApplicationController

  def new
    render :new
  end

  def show
    @band = Band.find_by(id: params[:id])
    render :show
  end

  def index
    @bands = Band.all
    render :index
  end

  def create
    @band = Band.new(band_params)
    @band.save
    redirect_to bands_url
  end

  def edit
    @band = Band.find_by(id: params[:id])
    if band.nil?
    else
      render :edit
    end
  end

  def destroy
    Band.find_by(id: params[:id]).destroy
    flash[:success] = "Band deleted"
    redirect_to bands_url
  end

  def update
    @band = Band.find_by(id: params[:id])
    if @band.update_attributes(band_params)
      @band.save
    else
      redirect_to edit_band_url
    end
  end


  private
    def band_params
      params.require(:band).permit(:name)
    end
end
