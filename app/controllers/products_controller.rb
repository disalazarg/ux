class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_questions, only: [:new, :edit, :create, :update]
  #load_and_authorize_resource find_by: :slug

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
    @answers = Answer.includes(picks: [alternative: :question]).internal
    respond_with(@product)
  end

  def edit
  end

  def create
    @product          = current_user.products.new(bare_product_params)
    @product.answer   = Answerable.process(product_params[:answer].merge(product_id: @product.id))
    @product.answers << @product.answer
    
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

  def results
    @product = Product.friendly.find params[:id]
    @base    = @product
      .answers
      .includes(picks: [alternative: :question])
      .internal
      .first

    @answers = @product
      .answers
      .includes(picks: [alternative: :question])
      .external
  end

  private
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    def set_questions
      @questions = Question.includes(:alternatives).where(id: [1,3,4])
    end

    def bare_product_params
      params.require(:product).permit(:name, :link, :description, :slug)
    end

    def product_params
      answer_params = [q1: [:alternative_id], q3: [:alternative_id], q4: [:alternative_id]]
      params.require(:product).permit(:name, :link, :description, :slug, answer: answer_params)
    end
end
