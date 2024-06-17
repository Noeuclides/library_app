class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    collection = User.all.order(:last_name)
    @pagy, @users = pagy(collection)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      render :new, notice: 'User was not created.', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :edit, notice: 'User was not updated.', status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully deleted.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role_ids)
  end
end
