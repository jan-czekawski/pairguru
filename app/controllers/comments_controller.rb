class CommentsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment created!"
      redirect_to @movie
    end
  end

  def destroy
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
end
