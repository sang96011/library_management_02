class Admin::AuthorsController < Admin::AdminController
  before_action :find_author, only: [:show, :edit, :update]

  def index
    @authors = if params[:value]
      Author.search params
    else
      Author.all
    end.paginate page: params[:page], per_page: Settings.per_page
    respond_to do |format|
      format.js
      format.html
      format.csv {send_data @authors.to_csv}
      format.xls {send_data @authors.to_csv(col_sep: "\t")}
    end
  end

  def show
    @books = @author.books
      .paginate page: params[:page], per_page: Settings.static_pages.per_page
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = t "admin.author.new.success"
      redirect_to admin_authors_path
    else
      flash[:danger] = t "admin.author.new.danger"
      render :new
    end
  end

  def edit
  end

  def update
    if @author.update_attributes author_params
      flash[:success] = t "admin.author.update.success"
      redirect_to admin_authors_path
    else
      flash[:danger] = t "admin.author.update.danger"
      render :edit
    end
  end

  private
  def find_author
    @author = Author.find_by id: params[:id]
    unless @author
      flash[:danger] = t "admin.book.error.not_found"
      redirect_to root_path
    end
  end

  def author_params
    params.require(:author).permit :name, :image, :date_of_birth, :body
  end
end
