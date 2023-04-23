class Api::V1::BookSerializer
  include JSONAPI::Serializer

  set_id :isbn
  attributes :title, :isbn, :publication_year, :edition, :price

  attribute :author do |object|
    "#{object.authors.pluck(:first_name, :middle_name, :last_name).map { |a| a.compact.join(' ') }.join(', ')}"
  end

  attribute :publisher do |object|
    "#{object.publisher.name}"
  end
end
