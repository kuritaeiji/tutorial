require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user, :not_activated) }
  let(:mail) { UserMailer.account_activation(user) }

  it('宛先がユーザーのメアド') do
    expect(mail.to).to eq([user.email])
  end

  it('題名がアカウント有効化') do
    expect(mail.subject).to eq('アカウント有効化')
  end

  it('リンクが存在する') do
    expect(mail.body).to match(CGI.escape(user.email))
    expect(mail.body).to match(CGI.escape(user.activation_token))
  end
end
