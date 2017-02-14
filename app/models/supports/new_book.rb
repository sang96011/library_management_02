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
end
