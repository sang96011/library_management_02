class Admin::UsersController < Admin::AdminController
  before_action :find_user, except: [:new, :index, :create]

  def index
    @users = if params[:value]
      User.search params
    else
      User.all
    end.paginate page: params[:page], per_page: Settings.per_page
    respond_to do |format|
      format.js
      format.html
      format.csv { send_data @users.to_csv }
      format.xls { send_data @users.to_csv(col_sep: "\t") }
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "admin.user.new.success"
      redirect_to admin_users_path
    else
      flash[:danger] = t "admin.user.new.danger"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "admin.user.update.success"
      redirect_to admin_users_path
    else
      flash[:danger] = t "admin.user.update.danger"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.user.destroy.success"
    else
      flash[:danger] = t "adnin.user.destroy.danger"
    end
    redirect_to :back
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "admin.user.error.not_found"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_digest
  end
end
