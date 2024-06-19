require 'rails_helper'

RSpec.feature 'borrow book', type: :feature do
  let(:member) { create(:user, :member) }
  let!(:book) { create(:book) }

  context 'Member actions' do
    scenario 'Member can borrow a book' do
      visit root_path

      expect(page).to have_current_path(new_user_session_path)

      fill_in 'Email', with: member.email
      fill_in 'Password', with: member.password

      click_button 'Log in'

      expect(page).to have_content('Total Books')
      expect(page).to have_content('Book List')

      click_button 'Available'

      expect(Borrow.count).to eq(1)
      expect(page).to have_content('Book borrowed successfully.')
    end
  end

  context 'Librarian actions' do
    let(:librarian) { create(:user, :librarian) }
    let!(:borrow) { create(:borrow, book: book, user: member) }

    scenario 'Librarian can mark a book as returned' do
      visit dashboard_all_borrows_path

      expect(page).to have_current_path(new_user_session_path)

      fill_in 'Email', with: librarian.email
      fill_in 'Password', with: librarian.password

      click_button 'Log in'

      expect(page).to have_content('Total Borrows')
      expect(page).to have_content('Borrow List')

      expect(borrow.returned_at).to be_nil
      expect(borrow).to be_in_progress

      click_button 'Mark as returned'

      borrow.reload
      expect(borrow.returned_at).not_to be_nil
      expect(borrow).to be_done
      expect(page).to have_content('Book returned successfully.')
    end
  end
end

