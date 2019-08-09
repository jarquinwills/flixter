class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!

  def new
    @course = Course.new
    redirect_to instructor_course_path(@course)
  end

  def show
    @course = @course.find(params[:id])
  end

  private

  def course_params
  params.require(:course).permit(:title, :description, :cost)
  end
end
