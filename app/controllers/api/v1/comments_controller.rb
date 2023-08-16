class Api::V1::CommentsController < ApplicationController
  before_action :set_movies_for_comments, only: %i[ index show create update destroy ]
  before_action :set_comment, only: %i[ show update destroy ]

  def index
    render json: { movie: @movie.id, comments: @movie.comments, status: 200 }
  end

  def show
    render json: { movie: @movie.id, comment: @comment, status: 200 }
  end

  def create
    @comment = @current_user.comments.build(comment_params)
    @comment.commentable = @movie
    
    if @comment.save
      render json: { movie: @movie.id, comment: @comment, status: 200 }
    else
      render json: { error: @comment.errors.full_messages, status: 422 }, status: :unprocessable_entity
    end
  end

  def update
    @comment.update(comment_params)
    render json: { message: "Comment was updated successfully!", status: 200 }
  end
  
  def destroy
    @comment.destroy
    render json: { message: "Comment was deleted successfully!", status: 200 }
  end

  private

  def set_movies_for_comments
    @movie ||= Movie.find(params[:movie_id])
  end

  def set_comment
    @comment ||= @movie.comments.find(params[:id])
  end
  
  def comment_params
    params.require(:comment).permit(:comment, :rate)
  end
end
