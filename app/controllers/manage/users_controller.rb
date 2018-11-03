class Manage::UsersController < ApplicationController
  before_action :authenticate_user!, :check_admin
  before_action :find_user, only: [:block, :unblock, :upgrade, :downgrade]
  layout "manage/home"

  def block
      @user.is_blocked = true
      if @user.save
        respond_to do |format|
          format.html { redirect_to request.referrer }
          format.js
        end
      # else
      #   flash[:danger] = "Fail"
      end
  end
  
  def unblock
    @user.is_blocked = false
      if @user.save
        respond_to do |format|
          format.html { redirect_to request.referrer }
          format.js
        end
      # else
      #   flash[:danger] = "Fail"
      end
  end

  def search_user
    if params[:search_user]
      @user_list = User.search(params[:search_user])
    else
      @user_list = User.all
    end
  end

  private  
  def check_admin
    unless current_user.is_admin?
      flash[:danger] = t ".not_permission"
    end
  end
  
  def find_user
    @user = User.find(params[:user_id])
  end

end