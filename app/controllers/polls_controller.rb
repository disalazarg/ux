class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @polls = Poll.all
    respond_with(@polls)
  end

  def show
    respond_with(@poll)
  end

  def new
    @poll = Poll.new
    respond_with(@poll)
  end

  def answer
    @data   = UXJWT.decode params[:token]
    @poll   = Poll.includes(questions: :alternatives).friendly.find params[:poll_id]
    @answer = Answer.new @data
  end

  def edit
  end

  def create
    @poll = Poll.new(poll_params)
    @poll.save
    respond_with(@poll)
  end

  def update
    @poll.update(poll_params)
    respond_with(@poll)
  end

  def destroy
    @poll.destroy
    respond_with(@poll)
  end

  private
    def set_poll
      @poll = Poll.friendly.find(params[:id])
    end

    def poll_params
      params.require(:poll).permit(:product_id, :title, :finish, :intro, :slug)
    end
end
