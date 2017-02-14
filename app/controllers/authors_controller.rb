class AuthorsController < ApplicationController
  before_action :find_author, only: [:show]
  def show
    @books = @author.books
      .paginate page: params[:page], per_page: Settings.static_pages.per_page

      if logged_in? && current_user.follower_authors.include?(@author)
        @user_relationship_author =
          current_user.follower.find_by followed_id: @author.id,
          followed_type: Author.name
      end
  end

  private
  def find_author
    @author = Author.find_by id: params[:id]
    unless @author
      flash[:danger] = t "authors.error.author_not_found"
      redirect_to root_path
    end
  end
end
