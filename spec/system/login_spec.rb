require 'rails_helper'

RSpec.describe 'ログイン・ログアウト', type: :system do
  let(:user) { create(:user) }

  describe '通常画面' do
    describe 'ログイン' do
      context '認証情報が正しい場合' do
        it 'ログインできること' do
          visit '/login'
          fill_in 'Email', with: user.email
          fill_in 'Password', with: '12345678'
          click_button 'ログイン'
          expect(current_path).to eq questions_path
          expect(page).to have_content('ログインしました')
        end
      end

      context 'PWに誤りがある場合' do
        it 'ログインできないこと' do
          visit '/login'
          fill_in 'Email', with: user.email
          fill_in 'Password', with: '1234'
          click_button 'ログイン'
          expect(current_path).to eq('/login')
          expect(page).to have_content('ログインに失敗しました')
        end
      end
    end

    describe 'ログアウト' do
      before do
        login
      end
      it 'ログアウトできること' do
        find('#header-profile').click
        click_on('ログアウト')
        expect(current_path).to eq root_path
        expect(page).to have_content('ログアウトしました')
      end
    end
  end
end
