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
end
