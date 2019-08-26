class User < ApplicationRecord
  has_many :courses
  has_many :enrollments
  has_many :enrolled_course, through: :enrollments, source: :course
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def enrolled_in?(course)
    return enrolled_course.include?(course)
  end

end
