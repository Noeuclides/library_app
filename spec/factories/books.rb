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
FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    genre { Faker::Book.genre }
    ean_prefix { "798" }
    registration_group { Faker::Number.number(digits: 4).to_s }
    registrant { Faker::Number.number(digits: 3).to_s }
    publication { Faker::Number.number(digits: 2).to_s }
    check_digit { Faker::Number.digit.to_s }
    total_copies { 1 }
  end
end
