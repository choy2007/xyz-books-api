class Book < ApplicationRecord
  belongs_to :publisher

  validates_presence_of :title, :isbn, :price, :publication_year, :publisher
end
