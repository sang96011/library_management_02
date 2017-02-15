class Admin::BooksController < Admin::AdminController
  before_action :find_book, only: [:show, :edit, :update]
  before_action :load_data, only: [:new, :edit, :index]

  def index
    @books = if params[:content]
      Book.search params
    else
      Book.all
    end.paginate page: params[:page], per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "admin.book.update.success"
      redirect_to admin_books_path
    else
      @categories = Category.all
      render :edit
    end
  end

  def new
    @book = Book.new
  end

  def show
  end

  def create
    @book = Book.new book_params
    if @book.save
      params[:book][:author_ids].each do |author_id|
        @book.book_authors.create! author_id: author_id unless author_id.blank?
      end
      params[:book][:category_ids].each do |category_id|
        @book.book_categories.create! category_id: category_id unless category_id.blank?
      end
      redirect_to admin_root_path
    else
      load_data
      render :new
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

  def book_params
    params.require(:book).permit :title, :image, :pages, :price, :quantity,
      :publish_date, :publisher_id
  end

  def load_data
    @supports = Supports::NewBook.new
  end
end
