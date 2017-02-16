class Admin::AuthorsController < Admin::AdminController
  def index
    @authors = if params[:value]
      Author.search params
    else
      Author.all
    end.paginate page: params[:page], per_page: Settings.per_page
    respond_to do |format|
      format.js
      format.html
      format.csv {send_data @authors.to_csv}
      format.xls {send_data @authors.to_csv(col_sep: "\t")}
     end
  end

  def show
    @authors = Author.find_by id: params[:id]
    check_nil @authors
  end
end
