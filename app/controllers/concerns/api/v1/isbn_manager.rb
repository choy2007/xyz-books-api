module Api::V1::IsbnManager
  extend ActiveSupport::Concern

  VALID_ISBN_10_REGEX = /^[0-9]{9}[0-9X]$/
  VALID_ISBN_13_REGEX = /^[9][7][8][0-9]{10}$/

  def convert_isbn
    @isbn = book_params[:isbn].gsub('-', '')

    if @isbn =~ VALID_ISBN_13_REGEX
      validate_isbn13
      render json: IsbnConverter.new(@isbn).convert_to_isbn10, status: 200
    elsif @isbn =~ VALID_ISBN_10_REGEX 
      validate_isbn10
      render json: IsbnConverter.new(@isbn).convert_to_isbn13, status: 200
    else
      render json: 'Invalid ISBN', status: 400
    end
  end

  private

  def validate_isbn10
    @isbn.chars
      .map { |c| c == 'X' ? 10: c.to_i }
      .zip(10.downto(1))
      .map { |m| m.reduce :* }.sum % 11 == 0
  end

  def validate_isbn13
    @isbn.chars
      .map { |c| c.to_i }
      .zip([1,3].cycle)
      .map { |m| m.reduce :* }.sum % 10 == 0
  end
end
