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
FactoryBot.define do
  factory :borrow do
    user factory: :user
    book factory: :book
    borrowed_at { Time.current }
    due_date { borrowed_at + 2.weeks }
    status { :in_progress }
  end
end
