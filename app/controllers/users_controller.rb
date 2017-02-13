class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :show, :create]
  before_action :verify_admin, only: :destroy
  before_action :find_user, except: [:new, :create, :index]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page]
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "users.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.profile_ update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.destroy.deleted"
    else
      flash[:danger] = t "users.destroy.not_deleted"
    end
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit :name,
      :email, :password, :password_confirmation
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @user
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "users.not_found"
      redirect_to root_path
    end
  end
end
