class AlternativesController < ApplicationController
  before_action :set_alternative, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @alternatives = Alternative.all
    respond_with(@alternatives)
  end

  def show
    respond_with(@alternative)
  end

  def new
    @alternative = Alternative.new
    respond_with(@alternative)
  end

  def edit
  end

  def create
    @alternative = Alternative.new(alternative_params)
    @alternative.save
    respond_with(@alternative)
  end

  def update
    @alternative.update(alternative_params)
    respond_with(@alternative)
  end

  def destroy
    @alternative.destroy
    respond_with(@alternative)
  end

  private
    def set_alternative
      @alternative = Alternative.find(params[:id])
    end

    def alternative_params
      params.require(:alternative).permit(:question_id, :number, :statement)
    end
end
