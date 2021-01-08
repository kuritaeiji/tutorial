require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe('GET /sign_up') do
    it('200レスポンスが返る') do
      get('/sign_up')
      expect(response.status).to eq(200)
    end
  end

  describe('POST /sign_up') do
    context('有効な値を入力した時') do
      let(:valid_params) { attributes_for(:user) }

      it('プロフィール画面にリダイレクト') do
        post('/sign_up', params: { user: valid_params })
        expect(response).to redirect_to(user_path(User.last))
      end
  
      it('ユーザーを作成する') do
        expect {
          post('/sign_up', params: { user: valid_params })
        }.to change(User, :count).by(1)
      end

      it('ログインする') do
        post('/sign_up', params: { user: valid_params })
        expect(logged_in?).to eq(true)
      end
    end
  end
end
