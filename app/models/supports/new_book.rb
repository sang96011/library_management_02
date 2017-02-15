class Supports::NewBook

  def publishers
    @publishers = Publisher.all
  end

  def categories
    @categories = Category.all
  end

  def authors
    @authors = Author.all
  end

  def list_categories
    @list_categories = Category.all.collect{|category|[category.name, category.id]}
  end
end
