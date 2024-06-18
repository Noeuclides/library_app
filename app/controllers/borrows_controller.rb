class BorrowsController < ApplicationController
  def create
    @borrow = current_user.borrows.new(borrow_params)
    authorize! :create, @borrow

    @borrow.borrowed_at = Time.current
    if @borrow.save
      redirect_to dashboard_member_path, notice: 'Book borrowed successfully.'
    else
      redirect_to dashboard_member_path, alert: 'Book not available for borrow.'
    end
  end

  def return_book
    authorize! :return, :book

    @borrow = Borrow.find(params[:id])
    @borrow.update(returned_at: Time.now, status: :done)
    @borrow.book.update(available_copies: @borrow.book.available_copies + 1)
    redirect_to dashboard_all_borrows_path, notice: 'Book returned successfully.'
  end

  private

  def borrow_params
    params.permit(:book_id)
  end
end
