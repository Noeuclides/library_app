require 'faker'

admin = User.new(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
admin.add_role(:admin)
admin.save
librarian = User.new(email: 'librarian@example.com', password: 'password', password_confirmation: 'password')
librarian.add_role(:librarian)
librarian.save

member = User.new(email: 'member@example.com', password: 'password', password_confirmation: 'password')
member.add_role(:member)
member.save

def generate_isbn
  registration_group = Faker::Number.number(digits: 4).to_s
  registrant = Faker::Number.number(digits: 3).to_s
  publication = Faker::Number.number(digits: 2).to_s
  check_digit = Faker::Number.digit.to_s

  {
    ean_prefix: "978",
    registration_group: registration_group,
    registrant: registrant,
    publication: publication,
    check_digit: check_digit
  }
end

books = []
50.times do
  isbn_components = generate_isbn
  copies = Faker::Number.between(from: 1, to: 5)
  book = Book.create(
    title: Faker::Book.title,
    author: Faker::Book.author,
    genre: Faker::Book.genre,
    ean_prefix: isbn_components[:ean_prefix],
    registration_group: isbn_components[:registration_group],
    registrant: isbn_components[:registrant],
    publication: isbn_components[:publication],
    check_digit: isbn_components[:check_digit],
    total_copies: copies,
    available_copies: copies
  )

  books << book
end

borrowed_books = books.sample(20) # Select 20 random books to be borrowed
borrowed_books.each do |book|
  borrowed_at = Faker::Date.between(from: 1.month.ago, to: Date.today)
  borrow = Borrow.create(
    user: member,
    book: book,
    borrowed_at: borrowed_at,
    due_date: borrowed_at + 2.weeks
  )
  borrow.overdue! if borrow.due_date > Time.current
end