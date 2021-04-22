require 'rails_helper'

RSpec.describe '質問', type: :system do
  let(:question) { create(:question) }
  let(:category) { create(:category) }
  let(:user ){ create(:user) }

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
          login_as_general
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
        login_as_general
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
      login_as_general
      visit '/questions/new'
      expect do
        fill_in 'Body', with: '〇〇がわかりません'
        click_button '質問する'
      end.to change { Question.count }.by(0)
      expect(page).to have_content('質問の投稿に失敗しました')
    end
  end

  describe '質問の詳細' do
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        visit question_path(question)
        expect(current_path).to eq login_path
        expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
      end
    end

    context 'ログインしている場合' do
      before do
        question
        login_as_general
      end
      it '質問の詳細が表示されること' do
        visit questions_path
        click_on question.title
        expect(page).to have_content(question.title)
        expect(page).to have_content(question.user.name)
        expect(page).to have_content(question.body)
      end
    end
  end

  describe '質問の更新' do
    before { question }
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        visit edit_question_path(question)
        expect(current_path).to eq('/login'), 'ログインページにリダイレクトされていません'
        expect(page).to have_content 'ログインしてください'
      end
    end

    context 'ログインしている場合' do
      context '自分の質問' do
        before do
          login_as_user user
          question
          visit questions_path
          find("#button-edit-#{question.id}").click
        end
        it '質問が更新できること' do
          fill_in 'Title', with: '編集後テストTitle'
          fill_in 'Body', with: '編集後テストBody'
          click_button '更新する'
          expect(current_path).to eq question_path(question)
          expect(page).to have_content('質問を更新しました')
          expect(page).to have_content('編集後テストTitle')
          expect(page).to have_content('編集後テストBody')
        end

        it '質問の作成に失敗すること' do
          fill_in 'Title', with: '編集後テストTitle'
          fill_in 'Body', with: ''
          click_button '更新する'
          expect(page).to have_content('質問を更新できませんでした')
        end
      end

      context '他人の質問' do
        it '編集ボタンが表示されないこと' do
          login_as_general
          visit questions_path
          expect(page).not_to have_selector("#button-edit-#{question.id}")
        end
      end
    end
  end
  describe '掲示板の削除' do
    before { question }
    context '自分の掲示板' do
      it '掲示板が削除できること', js: true do
        login_as_user user
        visit '/questions'
        page.accept_confirm { find("#button-delete-#{question.id}").click }
        expect(current_path).to eq('/questions'), '掲示板削除後に、掲示板の一覧ページに遷移していません'
        expect(page).to have_content('掲示板を削除しました'), 'フラッシュメッセージ「掲示板を削除しました」が表示されていません'
      end
    end

    context '他人の掲示板' do
      it '削除ボタンが表示されないこと' do
        login_as_general
        visit questions_path
        expect(page).not_to have_selector("#button-delete-#{question.id}"), '他人の掲示板に対して削除ボタンが表示されています'
      end
    end
  end
end
