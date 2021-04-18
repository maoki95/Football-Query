require 'rails_helper'

RSpec.describe '質問', type: :system do
  let(:question) { create(:question) }
  let(:user_question) { create(:board, user: user) }
  let(:category) { create(:category) }

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
  describe '入力情報正常系' do
    context 'ログインしている場合' do
      before do
        login
        find('#header-profile').click
        click_on('質問する')
      end
      it '質問が新規作成できること' do
        expect do
          fill_in 'Title', with: 'わかりません'
          fill_in 'Body', with: '〇〇がわかりません'
          click_button '質問する'
        end.to change { Question.count }.by(1)
        expect(current_path).to eq('/questions')
        expect(page).to have_content('質問を投稿しました')
      end

      it '画像付き質問が新規作成できること' do
        expect do
          fill_in 'Title', with: 'わかりません'
          fill_in 'Body', with: '〇〇がわかりません'
          file_path = Rails.root.join('spec', 'fixtures', 'sample.jpg')
          attach_file "Picture", file_path
          click_button '質問する'
        end.to change { Question.count }.by(1)
        expect(current_path).to eq('/questions')
        expect(page).to have_content('質問を投稿しました')
      end
      it 'カテゴリー付き質問が新規作成できること' do
        category
        expect do
          fill_in 'Title', with: 'わかりません'
          fill_in 'Body', with: '〇〇がわかりません'
          check "RB"
          click_button '質問する'
        end.to change { Question.count }.by(1)
        expect(current_path).to eq('/questions')
        expect(page).to have_content('RB')
        expect(page).to have_content('質問を投稿しました')
      end
    end
  end

  context '入力情報異常系' do
    it '質問投稿できない' do
      login
      visit '/questions/new'
      expect do
        fill_in 'Body', with: '〇〇がわかりません'
        click_button '質問する'
      end.to change { Question.count }.by(0)
      expect(page).to have_content('質問の投稿に失敗しました')
    end
  end
end
