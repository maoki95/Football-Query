class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update show]

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: 'ユーザー情報を変更しました'
    else
      flash.now['danger'] = 'ユーザー情報を変更できませんでした'
      render :edit
    end
  end

  def show
    @questions = current_user.questions.all.includes(:categories).order(created_at: :desc)
    answers = current_user.answers
    @best_answer = Question.where(best_answer_id: @user.answers.ids)

    if @best_answer.count >= 2
      current_user.Silver!
    elsif @best_answer.count >= 5
      current_user.rank.Gold!
    end

  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :avatar, :introduce)
  end
end
