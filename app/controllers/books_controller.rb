class BooksController < ApplicationController
  before_action :find_book, only: [:show]

  def show
    @comment = @book.comments.new
    @comments = @book.comments
      .paginate page: params[:page], per_page: Settings.static_pages.per_page
    @user_relationship_book =
      if logged_in? && current_user.follower_books.include?(@book)
        current_user.follower.find_by followed_id: @book.id,
          followed_type: Book.name
      end
  end

  private
  def find_book
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:danger] = t "books.error.book_not_found"
      redirect_to root_path
    end
  end
end
