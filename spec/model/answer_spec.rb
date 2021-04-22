require 'rails_helper'

RSpec.describe Answer, type: :model do

  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      answer = build(:answer)
      expect(answer).to be_valid
    end
  end

  context '本文が存在しない場合' do
    it '無効であること' do
      answer = build(:answer, body: nil)
      expect(answer).to be_invalid
      expect(answer.errors[:body]).to include('を入力してください')
    end
  end

  context '本文が1000文字以上の場合' do
    it '無効であること' do
      answer = build(:answer, body: 'a' * 1001)
      expect(answer).to be_invalid
      expect(answer.errors[:body]).to include('は1000文字以内で入力してください')
    end
  end
end
