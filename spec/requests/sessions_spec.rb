require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe('GET /log_in') do
    it('200レスポンスが返る') do
      get('/log_in')
      expect(response.status).to eq(200)
    end
  end
end
