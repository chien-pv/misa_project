class UsersManageController < ApplicationController
  authorize_resource :class => false
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user =  User.create(user_params)
    user.add_role "moderator" if user.present?
    redirect_to users_manage_index_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :salt, :encrypted_password)
  end

end
