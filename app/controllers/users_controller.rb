class UsersController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :destory]

  def index
  end

  def show
  end

  def edit
  end

  def destory
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  

  
end
