class Admin::BooksController < Admin::AdminController
  def index
    @books = Book.all
  end
end
