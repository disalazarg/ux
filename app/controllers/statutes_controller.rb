class StatutesController < ApplicationController
  before_action :set_statute, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  respond_to :html

  def index
    @statutes = Statute.all
    respond_with(@statutes)
  end

  def show
    respond_with(@statute)
  end

  def new
    @statute = Statute.new
    respond_with(@statute)
  end

  def edit
  end

  def create
    @statute = Statute.new(statute_params)
    @statute.save
    respond_with(@statute)
  end

  def update
    @statute.update(statute_params)
    respond_with(@statute)
  end

  def destroy
    @statute.destroy
    respond_with(@statute)
  end

  private
    def set_statute
      @statute = Statute.friendly.find(params[:id])
    end

    def statute_params
      params.require(:statute).permit(:name, :slug)
    end
end
