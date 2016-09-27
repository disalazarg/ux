class PageController < ApplicationController
  def index
  end

  def find
    @regions    = Region.all
    @districts  = District.all
    @statutes   = Statute.all
    @educations = Education.all

    @products   = Product.all
  end

  def search
    p = params[:search]

    @schools = School
      .by_region(p[:region])
      .by_district(p[:district])
      .by_statute(p[:statute])
      .by_education(p[:education])
      .order('RANDOM()')
      .limit(p[:max])

    respond_with @schools
  end

  def sendmail
    @contacts = Contact.where(school_id: params[:poll][:schools])
    @contacts.map do |contact|
      UxMailer.poll(contact, Product.first).deliver_later
    end

    flash.now[:notice] = "Mail sent successfully!"
    redirect_to root_path
  end

  def results
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

  def test
    @answers = Answer.includes(picks: [alternative: :question]).internal
  end

  def preview
    render layout: false
  end
end
