class BookAuthor < ApplicationRecord
  belongs_to :book, inverse_of: :book_authors
  belongs_to :author, inverse_of: :book_authors
end
