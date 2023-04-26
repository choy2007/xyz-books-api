module Api::V1::IsbnManager
  extend ActiveSupport::Concern

  VALID_ISBN_10_REGEX = /^[0-9]{9}[0-9X]$/
  VALID_ISBN_13_REGEX = /^[9][7][8][0-9]{10}$/

  def convert_isbn
    isbn = params[:isbn].gsub('-', '')

    if valid_isbn13?
      render json: IsbnConverter.new(isbn).convert_to_isbn10, status: 200
    elsif valid_isbn10?
      render json: IsbnConverter.new(isbn).convert_to_isbn13, status: 200
    else
      render json: 'Invalid ISBN', status: 400
    end
  end

  def valid_isbn13?
    isbn = params[:isbn].gsub('-', '')

    isbn =~ VALID_ISBN_13_REGEX

    isbn.chars
      .map { |c| c.to_i }
      .zip([1,3].cycle)
      .map { |m| m.reduce :* }.sum % 10 == 0
  end

  def valid_isbn10?
    isbn = params[:isbn].gsub('-', '')

    isbn =~ VALID_ISBN_10_REGEX

    isbn.chars
      .map { |c| c == 'X' ? 10: c.to_i }
      .zip(10.downto(1))
      .map { |m| m.reduce :* }.sum % 11 == 0
  end
end
