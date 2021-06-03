class BookCommnetsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.book.id = @book.id
    if @book_comment.save
      redirect_to book_path(@book.id)
    else
      # @comments = @book.comments
      render 'books/show'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
    redirect_to request.referer
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
