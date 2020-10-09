class ItemsController < ApplicationController
  def index
    @items_category = Item.where("buyer_id IS NULL AND trading_status = 0 AND category_id < 200").order(created_at: "DESC")
    @items_brand = Item.where("buyer_id IS NULL AND  trading_status = 0 AND brand_id = 1").order(created_at: "DESC")
  end

  def new
    @item = Item.new
    @image = @item.images.new
    @category_parent = Category.where(ancestry: nil)

    def get_category_child
      @category_child = Category.find(params[:parent_id]).children
      render json: @category_child
    end

    def get_category_grandchild
      @category_grandchild = Category.find("#{params[:child_id]}").children
      render json: @category_grandchild
    end
  end

  def buycheck
    if signed_in?
      @card = Card.get_card(current_user.card.customer_token) if current_user.card
    else
      redirect_to new_user_session_path
    end
  end
  def create
    createCategoryId()
    @item = Item.new(item_params)
    binding.pry
    if @item.valid? && @item.save
      redirect_to root_path
    else 
      @item.images.new
      return render new_item_path
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :introduction, :prefecture_id, 
      :category_id, :condition_id, :postage_payer_id,:postage_type_id, :brand_name, :size,
      :preparation_day_id, images_attributes: [:image_url]).merge(user_id: current_user.id)
  end

  def createCategoryId
    if params[:item][:category_child] == nil || params[:item][:category_child] == "child"
      @category_id = params[:item][:category_id]
    elsif params[:item][:category_grandchild] == "grandchild"
      @category_id = params[:item][:category_id_child]
    else
      @category_id = params[:item][:category_id_grandchild]
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
