# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '共通系', type: :system do
  before do
    visit root_path
  end
  describe 'トップページ' do
    it 'トップページが正しく表示されている' do
      expect(page).to have_content('使い方')
      expect(page).to have_content('質問一覧')
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
      expect(page).to have_content('プライバシ-ポリシー')
    end
  end
end
