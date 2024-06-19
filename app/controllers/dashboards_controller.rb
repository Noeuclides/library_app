class DashboardsController < ApplicationController
  before_action :authenticate_user!

  ITEMS = 5

  def show
    @url = dashboard_path

    if current_user.has_role?(:member)
      authorize! :read, :member_dashboard
      load_books
      @total_books = Book.count
      render :member
    else
      authorize! :read, :librarian_dashboard
      load_books
      @total_books = Book.count
      render :librarian
    end
  end

  def all_borrows
    authorize! :read, :librarian_dashboard
    load_borrows
    @url = dashboard_all_borrows_path
  end

  def member_borrows
    authorize! :read, :member_dashboard
    load_user_borrows
    @url = dashboard_member_borrows_path
  end

  private

  def load_books
    books = params[:search].present? ? Book.search(params[:search]) : Book.all
    @pagy, @books = pagy(books, items: ITEMS)
  end

  def load_borrows
    borrows = Borrow.not_done.includes(:user, :book)
    @total_borrows = borrows.count
    borrows = borrows.search(params[:search]) if params[:search].present?
    @pagy, @borrows = pagy(borrows.order(due_date: :desc), items: ITEMS)
  end

  def load_user_borrows
    user_borrows = current_user.borrows.not_done
    @total_borrows = user_borrows.count
    user_borrows = user_borrows.search(params[:search]) if params[:search].present?
    @pagy, @borrows = pagy(user_borrows.order(due_date: :desc), items: ITEMS)
  end
end
