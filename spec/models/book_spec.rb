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
require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "fields" do
    it { should have_db_column(:title).of_type(:string).with_options(null: false) }
    it { should have_db_column(:author).of_type(:string).with_options(null: false) }
    it { should have_db_column(:genre).of_type(:string) }
    it { should have_db_column(:ean_prefix).of_type(:string).with_options(null: false) }
    it { should have_db_column(:registration_group).of_type(:string).with_options(null: false) }
    it { should have_db_column(:registrant).of_type(:string).with_options(null: false) }
    it { should have_db_column(:publication).of_type(:string).with_options(null: false) }
    it { should have_db_column(:check_digit).of_type(:string).with_options(null: false) }
    it { should have_db_column(:total_copies).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:available_copies).of_type(:integer) }
  end

  describe "Associations" do
    it { should have_many(:borrows) }
  end
end
