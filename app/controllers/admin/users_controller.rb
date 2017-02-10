class Admin::UsersController < Admin::AdminController
  def index
    @users = if params[:value]
      User.search params
    else
      User.all
    end.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @users = User.find_by params[:id]
    check_nil @users
  end
end
