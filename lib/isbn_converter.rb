class IsbnConverter
  VALID_ISBN_10_REGEX = /^[0-9]{9}[0-9X]$/
  VALID_ISBN_13_REGEX = /^[9][8][7][0-9]{10}$/

  def initialize(isbn)
    @isbn = isbn
  end

  def convert_to_isbn10
    isbn10 = @isbn[3..-1].chop
    isbn10 += calculate_isbn10_check_digit(isbn10).to_s
  end

  def convert_to_isbn13
    isbn13 = "978" + @isbn.chop
    isbn13 += calculate_check_digit(isbn13).to_s
  end

  private

  def calculate_isbn10_check_digit(isbn)
    (11 - (isbn.chars.map { |c| c.to_i }.zip(10.downto(2)).map { |m| m.reduce :* }.sum) % 11) % 11
  end

  def calculate_isbn13_check_digit(isbn)
    (10 - (isbn.chars.map { |c| c.to_i }.zip([1,3].cycle).map { |m| m.reduce :* }.sum) % 10)
  end
end
