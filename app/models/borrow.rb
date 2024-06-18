# == Schema Information
#
# Table name: borrows
#
#  id          :bigint           not null, primary key
#  borrowed_at :datetime         not null
#  due_date    :datetime         not null
#  returned_at :datetime
#  status      :integer          default("in_progress"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  book_id     :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_borrows_on_book_id              (book_id)
#  index_borrows_on_user_id              (user_id)
#  index_borrows_on_user_id_and_book_id  (user_id,book_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#
class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, :book_id, :borrowed_at, presence: true
  validates :book_id, uniqueness: { scope: :user_id, message: "already borrowed by you" }

  enum status: { in_progress: 0, done: 1, rejected: 2, overdue: 3 }, _default: :in_progress
  before_create :set_due_at, :update_available_books

  scope :not_done, -> { where.not(status: :done) }
  scope :search, ->(term) { joins(:book).where('books.title ILIKE ? OR books.author ILIKE ? OR books.genre ILIKE ?', "%#{term}%", "%#{term}%", "%#{term}%") }

  def set_due_at
    self.due_date = borrowed_at + 2.weeks
  end

  def update_available_books
    available_copies = book.available_copies - 1
    book.update! available_copies: available_copies
  end
end
