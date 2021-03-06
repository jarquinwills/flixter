class Instructor::LessonsController < ApplicationController

  before_action :authenticate_user!
  before_action :require_authorized_for_current_user, only: [:create]
  before_action :requrie_authorized_for_current_lesson, only: [:update]
  skip_before_action :verify_authenticity_token, :only => [:update]

  def update
    current_lesson.update_attributes(lesson_params)
    render plain: 'Updated!'
  end

  def current_lesson
    @lesson ||= Lesson.find(params[:id])
  end

  def create
    @lesson = current_section.lessons.create(lesson_params)
    redirect_to instructor_course_path(current_section.course)
  end

  private

  def require_authorized_for_current_user
    if current_section.course.user != current_user
      return render plain: 'Unauthorized', status: :unauthorized
    end
  end 

  def requrie_authorized_for_current_lesson
    if current_lesson.section.course.user != current_user
      render plain: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :current_section
  def current_section
    @current_section ||= Section.find(params[:section_id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video, :row_order_position)
  end

end
