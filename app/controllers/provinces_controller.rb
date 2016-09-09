class ProvincesController < ApplicationController
  before_action :set_province, only: [:show, :edit, :update, :destroy]
  before_action :set_scope, only: [:index]

  respond_to :html

  def index
    @provinces = @scope.includes(:region).page params[:page]
    respond_with(@provinces)
  end

  def show
    respond_with(@province)
  end

  def new
    @province = Province.new
    respond_with(@province)
  end

  def edit
  end

  def create
    @province = Province.new(province_params)
    @province.save
    respond_with(@province)
  end

  def update
    @province.update(province_params)
    respond_with(@province)
  end

  def destroy
    @province.destroy
    respond_with(@province)
  end

  private
    def set_province
      @province = Province.friendly.find(params[:id])
    end

    def set_scope
      @scope = params[:region_id].nil? ? Province.all : Region.find(params[:region_id]).provinces
    end

    def province_params
      params.require(:province).permit(:region_id, :name, :lat, :lng, :slug)
    end
end
