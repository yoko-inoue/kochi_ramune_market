class UsersController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :destory]

  def index
  end

  def show
    @new_items = Item.last(3)
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
