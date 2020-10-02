class ItemsController < ApplicationController
  def index
    @items_category = Item.where("buyer_id IS NULL AND trading_status = 0 AND category_id < 200").order(created_at: "DESC")
    @items_brand = Item.where("buyer_id IS NULL AND  trading_status = 0 AND brand_id = 1").order(created_at: "DESC")
  end

  def new
    @item = Item.new
    # @item.images.new
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
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: "出品しました"
    else
      redirect_to new_item_path, notice: "出品できません。入力必須項目を確認してください"
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :brand_name, :size, :item_condition, :postage_payer, :preparation_day, :postage_type, :category_id,:prefecture_id, :trading_status, :buyer_id, images_attributes: [:url, :id])
  end

end
