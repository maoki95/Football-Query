module SystemHelper
  def login_as_general
    general_user = create(:user)
    visit '/login'
    fill_in 'Email', with: general_user.email
    fill_in 'Password', with: '12345678'
    click_button 'ログイン'
  end

  def login_as_user(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345678'
    click_button 'ログイン'
  end
end