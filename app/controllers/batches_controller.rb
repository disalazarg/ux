class BatchesController < ApplicationController
  before_action :set_product

  def index
    @batches  = @product.batches
  end

  def show
    @batch    = @product.batches.find params[:id]
    @polled   = Answer
      .where(product_id: @batch.product_id)
      .pluck(:contact_id)
    @contacts = @batch
      .contacts
      .where.not(id: @polled)
  end

  private
  def set_product
    @product = Product.friendly.find params[:product_id]
  end
end
