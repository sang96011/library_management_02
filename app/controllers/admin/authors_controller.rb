class Admin::AuthorsController < Admin::AdminController
  def index
    @authors = Author.all
  end
end
