class Book < ApplicationRecord
  belongs_to :publisher

  has_many :book_authors
  has_many :authors, through: :book_authors

  validates_presence_of :title, :isbn, :price, :publication_year, :publisher
end
