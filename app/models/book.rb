# == Schema Information
#
# Table name: books
#
#  id                 :bigint           not null, primary key
#  author             :string           not null
#  available_copies   :integer
#  check_digit        :string           not null
#  ean_prefix         :string           not null
#  genre              :string
#  publication        :string           not null
#  registrant         :string           not null
#  registration_group :string           not null
#  title              :string           not null
#  total_copies       :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Book < ApplicationRecord
  has_many :borrows

  validates :ean_prefix, length: { is: 3 }, numericality: { only_integer: true }
  validates :registration_group, length: { in: 1..5 }, numericality: { only_integer: true }
  validates :registrant, length: { in: 1..7 }, numericality: { only_integer: true }
  validates :publication, length: { in: 1..6 }, numericality: { only_integer: true }
  validates :check_digit, length: { is: 1 }, numericality: { only_integer: true }
  validate :valid_isbn_length
  validates :title, :author, :total_copies, presence: true

  before_create :set_available_copies

  scope :search, ->(term) { where('title ILIKE ? OR author ILIKE ? OR genre ILIKE ?', "%#{term}%", "%#{term}%", "%#{term}%") }

  def isbn
    "#{ean_prefix}-#{registration_group}-#{registrant}-#{publication}-#{check_digit}"
  end

  private

  def set_available_copies
    return unless available_copies.nil?

    self.available_copies = total_copies
  end

  def valid_isbn_length
    total_digits = ean_prefix.length + registration_group.length + registrant.length + publication.length + check_digit.length

    errors.add(:base, 'ISBN must have 13 digits') if total_digits != 13
  end
end
