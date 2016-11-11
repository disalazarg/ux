class PageController < ApplicationController
  def index
  end

  def find
    authorize! :find, :page

    @regions    = Region.all
    @districts  = District.all
    @statutes   = Statute.all
    @educations = Education.all

    @products   = Product.all
  end

  def search
    authorize! :search, :page

    p = params[:search]

    @schools = School
      .by_region(p[:region])
      .by_district(p[:district])
      .by_statute(p[:statute])
      .by_education(p[:education])

    @contacts = Contact
      .where(school_id: @schools.ids)
      .unpolled
      .includes(:school)
      .order('RANDOM()')
      .limit(p[:max].to_i)

    @product = Product.find p[:product].to_i

    respond_with @contacts
  end

  def sendmail
    authorize! :sendmail, :page

    @product  = Product.find params[:poll][:product_id]
    @contacts = Contact.where(id: params[:poll][:contacts])

    @contacts.map do |contact|
      UxMailer.poll(contact, @product).deliver_later
    end

    batch = Batch.create(product: @product)

    bulk_insert_polleds 1,     @contacts
    bulk_insert_batches batch, @contacts

    redirect_to root_path, notice: "Correos enviados con éxito"
  end

  def reminder
    authorize! :reminder, :page
  end

  def results
    authorize! :results, :page

    @products   = Product.all
    @regions    = Region.all
    @districts  = District.all
    @statutes   = Statute.all
    @educations = Education.all

    @product    = nil
    @base       = nil
    @answers    = []

    if result  = params[:results] and not params[:results][:product].empty? then
      @product = Product.friendly.find result[:product]

      @schools = @product
        .schools
        .by_region(result[:region])
        .by_district(result[:district])
        .by_statute(result[:statute])
        .by_education(result[:education])

      @base    = @product.answer

      @answers = @product
        .answers
        .external
        .includes(picks: [alternative: :question])
        .joins(:contact)
        .where(contacts: { school_id: @schools.ids })
    end
  end

  def preview
    render layout: false
  end

  private
  def bulk_insert_polleds poll_id, contacts
    values = contacts.map do |contact|
      "(#{poll_id}, #{contact.id}, NOW(), NOW())"
    end.join(", ")

    ActiveRecord::Base.connection.execute "INSERT INTO polleds(poll_id, contact_id, created_at, updated_at) VALUES " + values
  end

  def bulk_insert_batches batch, contacts
    values = contacts.map do |contact|
      "(#{batch.id}, #{contact.id})"
    end.join(", ")

    ActiveRecord::Base.connection.execute "INSERT INTO batches_contacts(batch_id, contact_id) VALUES " + values
  end
end
