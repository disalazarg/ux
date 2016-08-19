require 'rails_helper'

RSpec.describe "Alternatives", type: :request do
  describe "GET /alternatives" do
    it "works! (now write some real specs)" do
      get alternatives_path
      expect(response).to have_http_status(200)
    end
  end
end
