module BooksHelper
  def book_image(book, options = {}, &block)
    image = (book.image).tap do |image|

      if options[:size]
        image.set_size!(options[:size])
      else
        image.set_size!(:medium)
      end

      yield image if block_given?
    end

    image_tag(image.url, :class => "book_image #{options[:size]}", :alt => "#{book.title} Cover")
  end

  def book_author(book)
    [book.authors].flatten.to_sentence
  end
end
