require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe('GET /') do
    it('200レスポンスが返る') do
      get(root_path)
      expect(response.status).to eq(200)
    end
  end

  describe('GET /static_pages/help') do
    it('200レスポンスが返る') do
      get('/static_pages/help')
      expect(response.status).to eq(200)
    end
  end
end
