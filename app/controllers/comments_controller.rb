class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :find_book, only: [:create]

  def create
    @book.comments.new user_id: current_user.id, body: params[:comment][:body]
    if @book.save
      flash[:success] = t "comments.create.success"
      redirect_to @book
    else
      flash[:danger] = t "comments.create.error"
      redirect_to root_path
    end
  end

  private
  def find_book
    @book = Book.find_by id: params[:book_id]
    unless @book
      flash[:danger] = t "books.error.book_not_found"
      redirect_to root_path
    end
  end
end
