class UsersController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :destory]

  def index
  end

  def show
    @new_items = Item.where(user_id:current_user.id)
    @new_items1 = @new_items.order(created_at: :desc).limit(3)
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
