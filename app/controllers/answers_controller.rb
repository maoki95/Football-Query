class AnswersController < ApplicationController
  def create
    @answer = current_user.answers.build(answer_params)
    if @answer.save
      redirect_to question_path(@answer.question), success: t('.success')
    else
      redirect_to question_path(@answer.question), info: t('.fail')
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body).merge(question_id: params[:question_id])
  end
end
