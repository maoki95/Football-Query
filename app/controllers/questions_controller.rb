# frozen_string_literal: true

class QuestionsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @q = Question.ransack(params[:q])
    @category = Category.all
    @questions = @q.result(distinct: true).includes(:user)
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to questions_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render new_question_path
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers.includes(:user).order(created_at: :desc)
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])
    if @question.update(question_params)
      @question.adjust_status
      redirect_to @question, success: '質問を編集しました'
    else
      flash.now['danger'] = '質問の編集に失敗しました'
      render :edit
    end
  end

  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy!
    redirect_to profile_path, success: '質問を削除しました'
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :video, :best_answer_id, { pictures: [] }, :youtube, category_ids: [])
  end
end
