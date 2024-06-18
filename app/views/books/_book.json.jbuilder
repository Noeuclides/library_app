json.extract! book, :id, :title, :author, :genre, :ean_prefix, :registration_group, :registrant, :publication, :check_digit, :total_copies, :created_at, :updated_at
json.url book_url(book, format: :json)
