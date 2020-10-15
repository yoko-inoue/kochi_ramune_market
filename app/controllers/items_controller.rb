class ItemsController < ApplicationController
  def index
    @new_items = Item.last(5)
  end

  def new
    if signed_in?
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
    else
      redirect_to root_path
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
    if params[:item][:images_attributes] != nil
      if !@item.save
        flash.now[:alert] = '入力必須項目に入力してください'
        if @item[:price] == nil
          flash.now[:alert] = '金額を入力してください'
        elsif @item[:price] < 300
          flash.now[:alert] = '金額は300以上を入力してください'
        elsif @item[:price] > 9999999
          flash.now[:alert] = '金額は9,999,999以下を入力してください'
        end 
          @item = Item.new(item_params)
          render new_item_path
      end
    else
      flash.now[:alert] = '画像を追加してください'
      @item.images.build
      render new_item_path
    end
    if @item.save
    redirect_to root_path
    end
  end

  def show
    @item = Item.find(params[:id])
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).root
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
    @new_items = Item.last(3)
    @items = Item.category_sorce(@item.category,@item.id).last(3)
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def buy
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :introduction, :prefecture_id, 
      :condition_id, :postage_payer_id,:postage_type_id, :brand_name, :size,
      :preparation_day_id, images_attributes: [:image_url, :id, :_destroy ]).merge(category_id: @category_id, user_id: current_user.id)
  end

  def createCategoryId
    if params[:item][:category_grand_child] != "grand_child"
      @category_id_grandchild = params[:item][:category_grand_child]
      @category_id = @category_id_grandchild
    elsif params[:item][:category_child] != "child"
      @category_id_child = params[:item][:category_child]
      @category_id = @category_id_child
    else
      @category_id_parent = params[:item][:category_id]
      @category_id = @category_id_parent
    end
  end

  
end
