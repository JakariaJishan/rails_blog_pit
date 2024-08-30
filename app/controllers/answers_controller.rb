class AnswersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params.merge(user: current_user))
    if @answer.save
      redirect_to @question, notice: 'Answer was successfully created.'
    else
      redirect_to @question, alert: 'Failed to create answer.'
    end
  end

  def destroy
    @answer = current_user.answers.find(params[:id])
    @answer.destroy
    redirect_to @answer.question, notice: 'Answer was successfully deleted.'
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
