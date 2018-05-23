class GradesController < ApplicationController
  def create
    @grade = Grade.new(grade_params)
    @grade.user_id = current_user.id
    @grade.save
    redirect_to @grade.movie
  end

  def update
  end

  def destroy
  end
  
 def grade_params
    params.require(:grade).permit(:value, :movie_id)
  end
end
