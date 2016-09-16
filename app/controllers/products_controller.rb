class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_questions, only: [:new, :edit]
  load_and_authorize_resource find_by: :slug

  respond_to :html

  def index
    @products = Product.includes(:user).all
    respond_with(@products)
  end

  def show
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
  end

  def create
    render json: Answerable.process(product_params[:answer]) and return
    @product = current_user.products.new(product_params)
    @product.save
    respond_with(@product)
  end

  def update
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  def result
    @product = Product.friendly.find params[:id]
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def set_questions
      @questions = Question.includes(:alternatives).where(id: [1,3,4])
    end

    def product_params
      answer_params = [q1: [:alternative_id], q3: [:alternative_id], q4: [:alternative_id]]
      params.require(:product).permit(:name, :link, :description, :slug, answer: answer_params)
    end

    def prepare_results alternative
      {
        id: alternative.id,
        statement: alternative.statement,
        question_id: alternative.question_id,
        count: alternative.picks.count
      }
    end
end
