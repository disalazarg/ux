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
      UxMailer.greeter(contact).deliver_later
    end

    render text: "OK!"
  end
end
