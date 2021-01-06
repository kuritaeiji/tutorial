require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe('GET /sign_up') do
    it('200レスポンスが返る') do
      get('/sign_up')
      expect(response.status).to eq(200)
    end
  end
end
