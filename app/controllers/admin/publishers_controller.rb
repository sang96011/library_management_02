class Admin::PublishersController < Admin::AdminController
  before_action :find_publisher, except: [:new, :index, :create]

  def index
    @publishers = if params[:value]
      Publisher.search params
    else
      Publisher.all
    end.paginate page: params[:page], per_page: Settings.per_page
    respond_to do |format|
      format.js
      format.html
      format.csv {send_data @publishers.to_csv}
      format.xls {send_data @publishers.to_csv(col_sep: "\t")}
    end
  end

  def show
    @books = @publisher.books
      .paginate page: params[:page], per_page: Settings.static_pages.per_page
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new publisher_params
    if @publisher.save
      flash[:success] = t "admin.publisher.new.success"
      redirect_to admin_publishers_path
    else
      flash[:danger] = t "admin.publisher.new.danger"
      render :new
    end
  end

  def edit
  end

  def update
    if @publisher.update_attributes publisher_params
      flash[:success] = t "admin.publisher.update.success"
      redirect_to admin_publishers_path
    else
      flash[:danger] = t "admin.publisher.update.danger"
      render :edit
    end
  end

  def destroy
    if @publisher.destroy
      flash[:success] = t "admin.publisher.destroy.success"
    else
      flash[:danger] = t "adnin.publisher.destroy.danger"
    end
    redirect_to :back
  end

  private
  def find_publisher
    @publisher = Publisher.find_by id: params[:id]
    unless @publisher
      flash[:danger] = t "admin.publisher.error.not_found"
      redirect_to root_path
    end
  end

  def publisher_params
    params.require(:publisher).permit :name
  end
end
