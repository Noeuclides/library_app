class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user.has_role?(:member)
      redirect_to dashboard_member_path
    else
      redirect_to dashboard_librarian_path
    end
  end

  def librarian
    authorize! :read, :librarian_dashboard
  end

  def member
    authorize! :read, :member_dashboard
  end

  private
end
