require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  describe('POST /microposts') do
    context('ログインしていない時') do
      it('ログイン画面にリダイレクトする') do
        post('/microposts')
        expect(response).to redirect_to(log_in_path)
      end
    end
  end

  describe('DELETE /microposts') do

    context('ログインしていない時') do
      let(:micropost) { create(:micropost) }
      it('ログイン画面にリダイレクトする') do
        delete("/microposts/#{micropost.id}")
        expect(response).to redirect_to(log_in_path)
      end
    end

    context('正しいユーザーでない場合') do
      let(:user) { create(:user) }
      let!(:micropost) { create(:micropost) }

      it('ホーム画面にリダイレクトする') do
        log_in_in_request(user)
        delete("/microposts/#{micropost.id}")
        expect(response).to redirect_to(root_path)
      end

      it('マイクロポストは削除されない') do
        log_in_in_request(user)
        expect { delete("/microposts/#{micropost.id}") }.not_to change(Micropost, :count)
      end
    end
  end
end
