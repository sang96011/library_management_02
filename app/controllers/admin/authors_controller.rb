class Admin::AuthorsController < Admin::AdminController
  def index
    @authors = if params[:value]
      Author.search params
    else
      Author.all
    end.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @authors = Author.find_by id: params[:id]
    check_nil @authors
  end
end
