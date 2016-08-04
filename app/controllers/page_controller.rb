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

    render json: { schools: @schools } and return
  end
end
