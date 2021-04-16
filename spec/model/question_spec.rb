require 'rails_helper'

RSpec.describe Question, type: :model do

  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      question = build(:question)
      expect(question).to be_valid
    end
  end

  context 'タイトルが存在しない場合' do
    it '無効であること' do
      question = build(:question, title: nil)
      expect(question).to be_invalid
      expect(question.errors[:title]).to include('を入力してください')
    end
  end
  
  context '本文が存在しない場合' do
    it '無効であること' do
      question = build(:question, body: nil)
      expect(question).to be_invalid
      expect(question.errors[:body]).to include('を入力してください')
    end
  end


  context 'タイトルが150文字以上の場合' do
    it '無効であること' do
      question = build(:question, title: 'a' * 151)
      expect(question).to be_invalid
      expect(question.errors[:title]).to include('は150文字以内で入力してください')
    end
  end


  context '本文が10000文字以上の場合' do
    it '無効であること' do
      question = build(:question, body: 'a' * 10001)
      expect(question).to be_invalid
      expect(question.errors[:body]).to include('は10000文字以内で入力してください')
    end
  end
end