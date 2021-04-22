require 'rails_helper'

RSpec.describe 'アンサー', type: :system do
  let(:me) { create(:user) }
  let(:question) { create(:question) }
  let(:answer_by_me) { create(:answer, user: me, question: question) }
  let(:answer_by_others) { create(:answer, question: question) }

  describe 'アンサーのCRUD' do
    before do
      answer_by_me
      answer_by_others
    end
    describe 'アンサーの一覧' do
      it 'アンサーの一覧が表示されること' do
        login me
        visit question_path question
        within('#js-table-answer') do
          expect(page).to have_content(answer_by_me.body)
          expect(page).to have_content(answer_by_me.user.name)
        end
      end
    end

    describe 'アンサーの作成' do
      it 'アンサーを作成できること', js: true do
        login me
        visit question_path question
        fill_in 'アンサー', with: '新規アンサー'
        click_on '答える'
        answer = answer.last
        within("#answer-#{answer.id}") do
          expect(page).to have_content(me.name)
          expect(page).to have_content('新規アンサー')
        end
      end
      it 'アンサーの作成に失敗すること', js: true do
        login me
        visit question_path question
        fill_in 'アンサー', with: ''
        click_on '答える'
        expect(page).to have_content('アンサーを作成できませんでした')
      end
    end

    describe 'アンサーの編集' do
      context '他人のアンサーの場合' do
        it '削除ボタンが表示されないこと' do
          login me
          visit question_path question
          within("#answer-#{answer_by_others.id}") do
            expect(page).not_to have_selector('.js-delete-answer-button')
          end
        end
      end
    end
  end
end
