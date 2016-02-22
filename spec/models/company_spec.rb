require 'rails_helper'

RSpec.describe Company, type: :model do
  it "作成" do
    user = create(:user)
    rabbix = create(:company, user: user, name: 'ラビックス')
    expect(rabbix.name).to eq("ラビックス")
    prompt = create(:company, user: user, name: 'プロンプト')
    expect(prompt.name).to eq("プロンプト")
  end
end
