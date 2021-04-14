require 'rails_helper'

RSpec.describe User, type: :model do
  it '姓、名、メールがあり、パスワードは3文字以上であれば有効であること' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'メールはユニークであること' do
    user1 = create(:user)
    user2 = build(:user)
    user2.email = user1.email
    user2.valid?
    expect(user2.errors[:email]).to include('has already been taken')
  end

  it 'メールアドレス姓名は必須項目であること' do
    user = build(:user)
    user.email = nil
    user.name = nil
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
    expect(user.errors[:name]).to include("can't be blank")
  end

  it '名は50文字以下であること' do
    user = build(:user)
    user.name = "a" * 51
    user.valid?
    expect(user.errors[:name]).to include('is too long (maximum is 50 characters)')
  end

  it '自己紹介は150文字以下であること' do
    user = build(:user)
    user.introduce = "a" * 151
    user.valid?
    expect(user.errors[:introduce]).to include('is too long (maximum is 150 characters)')
  end
end