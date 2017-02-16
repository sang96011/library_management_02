class Admin::UsersController < Admin::AdminController
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
    @users = User.find_by params[:id]
    check_nil @users
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

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_digest
  end
end
