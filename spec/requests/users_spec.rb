require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe('GET /users') do
    context('ログインしていないとき') do
      it('ログイン画面にリダイレクト') do
        get('/users')
        expect(response).to redirect_to(log_in_path)
      end
    end
  end

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

  describe('GET /users/:id/edit') do
    let(:user) { create(:user) }

    context('ログインしていない時') do
      it('ログインページにリダイレクト') do
        get("/users/#{user.id}/edit")
        expect(response).to redirect_to(log_in_path)
      end
    end
  end

  describe('PATCH /users/:id') do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:valid_params) { attributes_for(:user) }

    context('ログインしていない時') do
      it('ログインページにリダイレクト') do
        patch("/users/#{user.id}", params: valid_params)
        expect(response).to redirect_to(log_in_path)
      end
    end

    context('正しいユーザーでない時') do
      it('ホーム画面にリダイレクト') do
        log_in_in_request(user)
        patch("/users/#{other_user.id}", params: valid_params)
        expect(response).to redirect_to(root_url)
      end

      it('フラッシュにメッセージ') do
        log_in_in_request(user)
        patch("/users/#{other_user.id}", params: valid_params)
        expect(flash[:danger]).to eq('正しいユーザーではありません')
      end
    end
  end

  describe('DELETE /user/:id') do
    let(:deleting_user) { create(:user) }

    context('ログインしていない時') do
      it('ログイン画面にリダイレクトする') do
        delete("/users/#{deleting_user.id}")
        expect(response).to redirect_to(log_in_path)
      end
    end

    context('管理者ユーザーの時') do
      let(:user) { create(:user, :not_admin) }
      it('ホーム画面にリダイレクトする') do
        log_in_in_request(user)
        delete("/users/#{deleting_user.id}")
        expect(response).to redirect_to(request.original_url)
      end
    end
  end
end
