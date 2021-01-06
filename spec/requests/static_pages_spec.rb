require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe('GET /') do
    it('200レスポンスが返る') do
      get(root_path)
      expect(response.status).to eq(200)
    end
  end

  describe('GET /help') do
    it('200レスポンスが返る') do
      get('/help')
      expect(response.status).to eq(200)
    end
  end

  describe('GET /about') do
    it('200レスポンスが返る') do
      get('/about')
      expect(response.status).to eq(200)
    end
  end

  describe('GET /contact') do
    it('200レスポンスが返る') do
      get('/contact')
      expect(response.status).to eq(200)
    end
  end
end
