class LikeBooksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :find_book, only: [:create, :destroy]

  def create
    current_user.like_book @book
    @user_relationship_book =
      if current_user.follower_books.include? @book
        current_user.follower.find_by followed_id: @book.id,
          followed_type: Book.name
      end
  end

  def destroy
    current_user.unlike_book @book
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
