class DistrictsController < ApplicationController
  before_action :set_district, only: [:show, :edit, :update, :destroy]
  before_action :set_scope, only: [:index, :show]

  respond_to :html

  def index
    @districts = @scope.includes(:province).page params[:page]
    respond_with(@districts)
  end

  def show
    respond_with(@district)
  end

  def new
    @district = District.new
    respond_with(@district)
  end

  def edit
  end

  def create
    @district = District.new(district_params)
    @district.save
    respond_with(@district)
  end

  def update
    @district.update(district_params)
    respond_with(@district)
  end

  def destroy
    @district.destroy
    respond_with(@district)
  end

  private
    def set_district
      @district = District.friendly.find(params[:id])
    end

    def set_scope
      if not params[:region_id].nil?
        @scope = Region.find(params[:region_id])
          .districts
      elsif not params[:province_id].nil?
        @scope = Province.find(params[:province_id])
          .districts
      else
        @scope = District.all
      end
    end

    def district_params
      params.require(:district).permit(:province_id, :name, :lat, :lng, :slug)
    end
end
