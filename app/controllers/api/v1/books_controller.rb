class Api::V1::BooksController < ApplicationController
  include Api::V1::IsbnManager

  before_action :set_book, only: [:show, :update, :destroy]

  # GET /books
  def index
    @books = Book.all

    render json: Api::V1::BookSerializer.new(@books).serializable_hash.to_json, status: 200
  end

  # GET /books/1
  def show
    render json: Api::V1::BookSerializer.new(@book).serializable_hash.to_json, status: 200
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find_by(isbn: params[:isbn])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :isbn, :price, :publication_year, :publisher_id, :image_url, :edition)
    end
end
