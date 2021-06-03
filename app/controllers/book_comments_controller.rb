class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  # コメントした人のみ消せる

  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.book_id = @book.id
    @book_comment.save

  end

  def destroy
    @book = Book.find(params[:book_id])
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
    # redirect_to request.referer 非同期化による
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
