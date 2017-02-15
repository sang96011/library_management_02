class FollowAuthorsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :find_author, only: [:create, :destroy]

  def create
    current_user.follow_author @author
      if current_user.follower_authors.include?(@author)
        @user_relationship_author =
          current_user.follower.find_by followed_id: @author.id,
          followed_type: Author.name
      end
  end

  def destroy
    current_user.unfollow_author @author
  end

  private
  def find_author
    @author = Author.find_by id: params[:author_id]
    unless @author
      flash[:danger] = t "authors.error.author_not_found"
      redirect_to root_path
    end
  end
end
