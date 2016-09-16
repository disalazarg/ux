class PicksController < ApplicationController
  before_action :set_pick, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  respond_to :html

  def index
    @picks = Pick.all
    respond_with(@picks)
  end

  def show
    respond_with(@pick)
  end

  def new
    @pick = Pick.new
    respond_with(@pick)
  end

  def edit
  end

  def create
    @pick = Pick.new(pick_params)
    @pick.save
    respond_with(@pick)
  end

  def update
    @pick.update(pick_params)
    respond_with(@pick)
  end

  def destroy
    @pick.destroy
    respond_with(@pick)
  end

  private
    def set_pick
      @pick = Pick.find(params[:id])
    end

    def pick_params
      params.require(:pick).permit(:answer_id, :alternative_id)
    end
end
