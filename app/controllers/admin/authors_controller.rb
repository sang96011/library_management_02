class Admin::AuthorsController < Admin::AdminController
  before_action :find_author, only: [:show]

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

  private
  def find_author
    @author = Author.find_by id: params[:id]
    unless @author
      flash[:danger] = t "admin.book.error.not_found"
      redirect_to root_path
    end
  end
end
