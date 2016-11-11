class BatchesController < ApplicationController
  before_action :set_product

  def index
    authorize! :show, @product

    @batches  = @product.batches
  end

  def show
    authorize! :show, @product

    @batch    = @product.batches.find params[:id]
    @polled   = Answer
      .where(product_id: @batch.product_id)
      .pluck(:contact_id)
    @contacts = @batch
      .contacts
      .includes(:school)
      .where.not(id: @polled)
  end

  def reminder
    authorize! :show, @product
    
    @contacts = Contact.where(id: params[:batch][:contacts])
    @contacts.map do |contact|
      UxMailer.reminder(contact, @product).deliver_later
    end

    redirect_to root_path, notice: "Correos enviados con éxito"
  end

  private
  def set_product
    @product = Product.friendly.find params[:product_id]
  end
end
