require 'rails_helper'

RSpec.describe "Parties", type: :request do
  describe "POST /parties" do
    let(:name) { nil }

    it "creates parties" do
      post "/parties"

      expect(response.status).to eq(200)
    end
  end
end
