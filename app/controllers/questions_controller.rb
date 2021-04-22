# frozen_string_literal: true

class QuestionsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @questions = Question.all.includes(:user)
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

  private

  def question_params
    params.require(:question).permit(:title, :body, :video, { pictures: [] }, :youtube, category_ids: [])
  end
end
