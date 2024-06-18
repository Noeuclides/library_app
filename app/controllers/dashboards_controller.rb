class DashboardsController < ApplicationController
  before_action :authenticate_user!

  ITEMS = 5

  def show
    if current_user.has_role?(:member)
      redirect_to dashboard_member_path
    else
      redirect_to dashboard_librarian_path
    end
  end

  def librarian
    authorize! :read, :librarian_dashboard
    books = params[:search].present? ? Book.search(params[:search]) : Book.all

    @pagy, @books = pagy(books, items: ITEMS)
    @total_books = Book.count
    @url = dashboard_librarian_path
  end

  def all_borrows
    authorize! :read, :librarian_dashboard

    borrows = Borrow.not_done.includes(:user, :book)
    @total_borrows = borrows.count
    borrows = borrows.search(params[:search]) if params[:search].present?

    # #TODO put this update on a job
    # borrows.where("due_date > ?", Time.current).update status: :overdue

    @pagy, @borrows = pagy(borrows.order(due_date: :desc), items: ITEMS)
    @url = dashboard_all_borrows_path
  end

  def member
    authorize! :read, :member_dashboard
    books = params[:search].present? ? Book.search(params[:search]) : Book.all

    @pagy, @books = pagy(books, items: ITEMS)
    @total_books = Book.count
    @url = dashboard_member_path
  end

  def member_borrows
    authorize! :read, :member_dashboard

    user_borrows = current_user.borrows.not_done
    @total_borrows = user_borrows.count
    user_borrows = user_borrows.search(params[:search]) if params[:search].present?

    # #TODO put this update on a job
    # user_borrows.where("due_date > ?", Time.current).update status: :overdue

    @pagy, @borrows = pagy(user_borrows.order(due_date: :desc), items: ITEMS)
    @url = dashboard_member_borrows_path
  end
end
