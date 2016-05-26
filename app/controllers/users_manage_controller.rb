class UsersManageController < ApplicationController
  authorize_resource :class => false
  before_action :get_user, only: [:edit, :update, :destroy]
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

  def update
    if params[:user][:password].blank? || params[:user][:password].nil?
      user = @user.update(user_update)
    else
      user = @user.update(user_params)
    end
    if user
      flash[:notice] = "Cập nhật thành công!"
    else
      flash[:alert] =  "Cập nhật không thành công"
    end
    redirect_to users_manage_index_path
  end

  def edit
  end

  def destroy
    if @user.destroy
      flash[:notice] = " Xóa thành công!"
    else
      flash[:alert] =  " Xóa không thành công"
    end
    redirect_to users_manage_index_path
  end

  private

  def get_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :salt, :encrypted_password)
  end

  def user_update
    params.require(:user).permit(:name, :email)
  end

end
