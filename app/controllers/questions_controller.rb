class QuestionsController < ApplicationController

  def index
    @questions = Question.all.includes(:user)
  end

end