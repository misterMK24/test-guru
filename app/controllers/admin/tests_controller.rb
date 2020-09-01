class Admin::TestsController < Admin::BaseController
  before_action :current_test, only: %i[show edit update destroy]
  
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
    render plain: "There are no tests for this test" if @tests.empty?
  end

  def show
    @questions = @test.questions
  end

  def new
    @test = Test.new
  end

  def edit
  end

  def update
    if @test.update(test_params)
      redirect_to [:admin, @test]
    else
      render :edit
    end
  end

  def create
    @test = current_user.authored_tests.new(test_params)

    if @test.save
      redirect_to [:admin, @test], notice: t('.success')
    else
      render :new
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def current_test
    @test = Test.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render plain: "There is no such test"
  end

  def rescue_with_test_not_found
    render plain: 'Test was not found'
  end
end