require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  let(:book) { create(:book) }
  let(:borrow) { create(:borrow) }

  context 'when user is an admin' do
    let(:user) { create(:user, :admin) }

    it 'can manage all' do
      expect(ability).to be_able_to(:manage, :all)
    end
  end

  context 'when user is a librarian' do
    let(:user) { create(:user, :librarian) }

    it 'can manage books' do
      expect(ability).to be_able_to(:manage, Book)
    end

    it 'can read and update borrows' do
      expect(ability).to be_able_to(:read, Borrow)
      expect(ability).to be_able_to(:update, Borrow)
    end

    it 'can read librarian dashboard' do
      expect(ability).to be_able_to(:read, :librarian_dashboard)
    end

    it 'can return books' do
      expect(ability).to be_able_to(:return, :book)
    end
  end

  context 'when user is a member' do
    let(:user) { create(:user, :member) }

    it 'can read books' do
      expect(ability).to be_able_to(:read, Book)
    end

    it 'can read and create borrows' do
      expect(ability).to be_able_to(:read, Borrow)
      expect(ability).to be_able_to(:create, Borrow)
    end

    it 'can read member dashboard' do
      expect(ability).to be_able_to(:read, :member_dashboard)
    end
  end
end
