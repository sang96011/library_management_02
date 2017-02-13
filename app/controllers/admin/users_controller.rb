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
end
