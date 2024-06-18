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
require 'rails_helper'

RSpec.describe Borrow, type: :model do
  describe "fields" do
    it { should have_db_column(:borrowed_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:due_date).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:returned_at).of_type(:datetime) }
    it { should have_db_column(:status).of_type(:integer).with_options(null: false) }
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  describe "indexes" do
    it { should have_db_index([:user_id, :book_id]).unique }
  end

  describe "Validations" do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    it 'validates uniqueness of book per user' do
      create(:borrow, user: user, book: book)
      duplicate_borrowing = build(:borrow, user: user, book: book)

      expect(duplicate_borrowing).not_to be_valid
      expect(duplicate_borrowing.errors[:book_id]).to include('already borrowed by you')
    end
  end
end
