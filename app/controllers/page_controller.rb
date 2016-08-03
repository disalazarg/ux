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
    render json: params[:search] and return
  end
end
