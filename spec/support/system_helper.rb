module SystemHelper
  def login(user)
    user = create(:user)
    visit '/login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345678'
    click_button 'ログイン'
  end
end
