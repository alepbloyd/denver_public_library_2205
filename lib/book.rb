class Book

  attr_reader :author_first_name,
              :author_last_name,
              :title,
              :publication_date

  def initialize(input)
    @author_first_name = input[:author_first_name]
    @author_last_name = input[:author_last_name]
    @title = input[:title]
    @publication_date = input[:publication_date]
  end

  def author
    "#{@author_first_name} #{@author_last_name}"
  end

  def publication_year
    @publication_date[-4,4]
  end

end
