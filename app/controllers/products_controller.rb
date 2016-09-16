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

  def results
<<<<<<< HEAD
    @product = Product.friendly.find params[:id]
=======
    # @results = ActiveRecord::Base.connection.exec_query """
    #   SELECT
    #     questions.id AS question_id,
    #     alternatives.id AS alternative_id,
    #     COUNT(picks.id) AS count
    #   FROM
    #     alternatives
    #     INNER JOIN questions ON
    #       alternatives.question_id = questions.id
    #     LEFT OUTER JOIN picks ON
    #       picks.alternative_id = alternatives.id
    #     LEFT OUTER JOIN answers ON
    #       picks.answer_id = answers.id
    #     LEFT OUTER JOIN products ON
    #       answers.product_id = products.id
    #   WHERE
    #     products.id = #{params[:id]}
    #   GROUP BY
    #     questions.id, alternatives.id
    # """
    @answers = Answer.external.includes(:contact, :product, picks: :alternative).where(product_id: params[:id])

    respond_with @answers
  end

  def resultset
    @product = Product.find params[:id]
>>>>>>> 0dff7f4cfe219f2c8fd16c1b18c702cd0ddc3da1
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
