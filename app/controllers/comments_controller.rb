class CommentsController < ApplicationController
  before_action :set_movie, only: [:create]
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @movie.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment created!"
    else
      @comment.handle_errors
    end
    redirect_to @movie
  end

  def destroy
    @comment.delete
    flash[:notice] = "Comment deleted!"
    redirect_to @comment.movie
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
