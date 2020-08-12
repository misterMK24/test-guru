class QuestionsController < ApplicationController
  before_action :current_test_get, only: [:create, :index]
  before_action :current_question_get, only: [:show, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
    render plain: "There are no questions for this test" if @questions.empty?
  end

  def show
  end

  def new
  end

  def create
    @question = @test.questions.create(question_params)

    if @question.save
      redirect_to @question
    else
      redirect_to action: 'new'
    end
  end

  def destroy
    @question.destroy
    render plain: 'Question was successfully deleted'
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def current_test_get
    @test = Test.find(params[:test_id])
  rescue ActiveRecord::RecordNotFound
    render plain: "There is no such test"
  end

  def current_question_get
    @question = Question.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: 'Question was not found'
  end
end