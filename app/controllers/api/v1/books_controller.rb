class Api::V1::BooksController < ApplicationController
  include Api::V1::IsbnManager

  before_action :set_book, only: [:show]

  def show
    raise InvalidIsbn unless valid_isbn13?

    if @book
      render json: Api::V1::BookSerializer.new(@book).serializable_hash.to_json, status: 200
    else
      render json: { error: { message: "Book not found" } }, status: 404
    end
  rescue InvalidIsbn
    render json: { errors: 'Invalid ISBN' }, status: 400
  end

  private

  def set_book
    @book = Book.find_by(isbn: params[:isbn].gsub('-', ''))
  end
end
