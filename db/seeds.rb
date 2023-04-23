def delete_all
  Book.delete_all
  Author.delete_all
  Publisher.delete_all
  BookAuthor.delete_all
end

def create_authors
  authors = [
    { first_name: 'Joel', last_name: 'Hartse' },
    { first_name: 'Hannah', middle_name: 'P.', last_name: 'Templer' },
    { first_name: 'Marguerite', middle_name: 'Z.', last_name: 'Duras' },
    { first_name: 'Kingsley', last_name: 'Amis' },
    { first_name: 'Fannie', middle_name: 'Peters', last_name: 'Flagg' },
    { first_name: 'Camille', middle_name: 'Byron', last_name: 'Paglia' },
    { first_name: 'Rainer', middle_name: 'Steel', last_name: 'Rilke' }
  ]

  authors.each do |author|
    author = Author.new(author)
    author.save

    instance_variable_set("@#{author.first_name.downcase}", author)
  end

  p "Created #{Author.count} authors"
end

def create_publishers
  publishers = [
    { name: 'Paste Magazine' },
    { name: 'Publishers Weekly' },
    { name: 'Graywolf Press' },
    { name: "McSweeney's" }
  ]

  publishers.each do |publisher|
    publisher = Publisher.new(publisher)
    publisher.save

    instance_variable_set("@#{publisher.name.parameterize.underscore}", publisher)
  end

  p "Created #{Publisher.count} publishers"
end

def create_books
  books = [
    { title: 'American Elf', isbn: '978-1-891830-85-3', publication_year: '2004', publisher: @paste_magazine, edition: 'Book 2', price: 1000, image_url: 'https://m.media-amazon.com/images/I/51482iujS7L.jpg' },
    { title: 'Cosmoknights', isbn: '978-1-60309-454-2', publication_year: '2019', publisher: @publishers_weekly, edition: 'Book 1', price: 2000, image_url: 'https://m.media-amazon.com/images/I/81dsfFoWPNL.jpg' },
    { title: 'Essex County', isbn: '978-1-60309-038-4', publication_year: '1990', publisher: @graywolf_press, price: 500, image_url: 'https://m.media-amazon.com/images/I/61Bsh18xq4L._SX331_BO1,204,203,200_.jpg' },
    { title: 'Hey, Mister (Vol 1)', isbn: '978-1-891830-02-0', publication_year: '2000', publisher: @graywolf_press, edition: 'After School Special', price: 1200, image_url: 'https://m.media-amazon.com/images/P/1891830023.01._SCLZZZZZZZ_SX500_.jpg' },
    { title: 'The Underwater Welder', isbn: '978-1-60309-398-9', publication_year: '2022', publisher: @mcsweeney_s, price: 3000,  image_url: 'https://i.ebayimg.com/images/g/k3gAAOSwEFpg6GVy/s-l500.jpg' }
  ]

  books.each do |book|
    book = Book.new(book)
    book.save

    instance_variable_set("@#{book.title.parameterize.underscore}", book)    
  end

  p "Created #{Book.count} books"
end

def create_book_authors
  @american_elf.authors << [@joel, @hannah, @marguerite]
  @cosmoknights.authors << @kingsley
  @essex_county.authors << @kingsley
  @hey_mister_vol_1.authors << [@hannah, @fannie, @camille]
  @the_underwater_welder.authors << @rainer

  p "Created #{BookAuthor.count} book authors"
end

ActiveRecord::Base.transaction do
  delete_all
  create_authors
  create_publishers
  create_books
  create_book_authors
end
