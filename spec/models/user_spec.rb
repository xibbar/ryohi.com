require 'rails_helper'

RSpec.describe User, type: :model do
  it 'ユーザーの作成' do
    user =  create(:user, login: 'xibbar')
    expect(user.login).to eq("xibbar")
  end
end
