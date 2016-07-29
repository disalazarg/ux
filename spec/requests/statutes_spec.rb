require 'rails_helper'

RSpec.describe "Statutes", type: :request do
  describe "GET /statutes" do
    it "works! (now write some real specs)" do
      get statutes_path
      expect(response).to have_http_status(200)
    end
  end
end
