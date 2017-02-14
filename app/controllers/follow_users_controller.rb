class FollowUsersController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :find_user, only: [:create, :destroy]
  def create
    current_user.follow_user @user
    if logged_in? && current_user.follower_users.include?(@user)
      @user_relationship_user =
        current_user.follower.find_by followed_id: @user.id,
        follower_type: User.name, followed_type: User.name
    end
  end

  def destroy
    current_user.unfollow_user @user
  end

  private
  def find_user
    @user = User.find_by id: params[:user_id]
    unless @user
      flash[:danger] = t "users.not_found"
      redirect_to root_path
    end
  end
end
