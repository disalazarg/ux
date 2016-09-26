class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @answers = Answer.includes(:contact, :product).all
    respond_with(@answers)
  end

  def show
    respond_with(@answer)
  end

  def new
    @answer = Answer.new
    respond_with(@answer)
  end

  def edit
  end

  def create
    @answer = Answerable.process answer_params

    @answer.save
    respond_with @answer
  end

  def update
    @answer.update(answer_params)
    respond_with(@answer)
  end

  def destroy
    @answer.destroy
    respond_with(@answer)
  end

  private
    def set_answer
      @answer = Answer.includes({ contact: :school }, :product, { picks: { alternative: :question }}).find(params[:id])
    end

    def answer_params
      pms = [q1: [:alternative_id], q2: [:alternative_id], q3: [:alternative_id], q4: [:alternative_id], q5: [:alternative_id]]
      params.require(:answer).permit(:contact_id, :product_id, *pms)
    end
end
