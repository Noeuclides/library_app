class BorrowsController < ApplicationController
  def create
    @borrows = current_user.borrows.new(borrowing_params)
    @borrows.borrowed_at = Time.current
    if @borrows.save
      redirect_to dashboard_member_path, notice: 'Book borrowed successfully.'
    else
      redirect_to dashboard_member_path, alert: 'Book not available for borrow.'
    end
  end

  def return_book
    @borrow = Borrow.find(params[:id])
    @borrow.update(returned_at: Time.now, status: :done)
    @borrow.book.update(available_copies: @borrow.book.available_copies + 1)
    redirect_to dashboard_all_borrows_path, notice: 'Book returned successfully.'
  end

  private

  def borrowing_params
    params.permit(:book_id)
  end
end
