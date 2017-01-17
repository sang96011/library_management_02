class StaticPagesController < ApplicationController
  before_action :categories, only: [:show]

  def show
    if valid_page?
      @books = Book.all
        .paginate page: params[:page], per_page: Settings.static_pages.per_page

      render template: "static_pages/#{params[:act]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist? Pathname.new Rails.root + "app/views/static_pages/#{params[:act]}.html.erb"
  end

  def categories
    @categories = Category.all
  end
end
