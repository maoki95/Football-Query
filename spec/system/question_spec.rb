require 'rails_helper'

RSpec.describe '質問', type: :system do
  let(:question) { create(:question) }
  let(:user_question) { create(:board, user: user) }

  describe '質問の表示' do
    describe '質問の一覧' do
        context '質問が一件もない場合' do
          it '何もない旨のメッセージが表示されること' do
            visit '/questions'
            expect(page).to have_content('質問がありません')
          end
        end

        context '質問がある場合' do
          it '質問の一覧が表示されること' do
            question
            visit '/questions'
            expect(page).to have_content(question.title)
            expect(page).to have_content(question.user.name)
            expect(page).to have_content(question.body)
          end
        end
    end
  end
  context '入力情報正常系' do
    it '質問が新規作成できること' do
      login
      visit '/questions/new'
      expect {
        fill_in 'Title', with: 'わかりません'
        fill_in 'Body', with: '〇〇がわかりません'
        click_button '質問する'
      }.to change { Question.count }.by(1)
      expect(page).to have_content('質問を投稿しました')
    end
  end

  context '入力情報異常系' do
    it '質問投稿できない' do
      login
      visit '/questions/new'
      expect {
        fill_in 'Body', with: '〇〇がわかりません'
        click_button '質問する'
      }.to change { Question.count }.by(0)
      expect(page).to have_content('質問の投稿に失敗しました')
    end
  end
end
