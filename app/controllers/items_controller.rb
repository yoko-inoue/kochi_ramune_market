class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :buycheck, :buy, :purchase, :edit, :update, :destroy]
  before_action :set_ransack

  def index
    @new_items = Item.last(5)
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def search
    @search = params[:keyword]
    sort = params[:sort] || "created_at DESC"
    @items = Item.search(params[:keyword]).limit(132)
    @count = @items.count
    if @count == 0
      @items = Item.order(sort)
    end
    sort_result = params[:sort] || "created_at DESC"
    if sort_result == "price asc"
      @items = @items.sort {|a, b| a[:price] <=> b[:price]}
    elsif sort_result == "price desc"
      @items = @items.sort {|a, b| b[:price] <=> a[:price]}
    elsif sort_result == "created_at asc"
      @items = @items.sort {|a, b| a[:created_at] <=> b[:created_at]}
    elsif sort_result == "created_at desc"
      @items = @items.sort {|a, b| b[:created_at] <=> a[:created_at]}
    end
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
    if signed_in? && @item.user_id != current_user.id
      if @item.buyer_id == nil
      @card = Card.get_card(current_user.card.customer_token) if current_user.card
      @sending = current_user.sending_destination
      binding.pry
      else
        redirect_to root_path
      end
    else
      flash.now[:alert] = 'ログインまたは新規登録を行ってください'
      redirect_to new_user_session_path
    end
  end

  def create
    createCategoryId
    @item = Item.new(item_params)
    @item.category_id = @category_id
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
          return render :new
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

  def edit
    if @item.user_id == current_user.id
    else
      redirect_to root_path
    end
  end

  def update
    if @item.user_id == current_user.id
      changeCategoryId()
      if @item.update(item_params)
        @item.update(category_id: @category_id)
        redirect_to item_path
      else
        flash.now[:alert] = '画像を追加してください'
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  def show
    @id = Item.find_by(id: params[:id])
    if @id == nil
      redirect_to root_path
    end
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).root
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
    @items = Item.category_sorce(@item.category,@item.id).last(3)
    @comment = Comment.new
    @comments = @item.comments.includes(:user).order(created_at: :desc)
    @new_items_user = Item.where(user_id:@item.user_id)
    @new_items = @new_items_user.order(created_at: :desc).limit(3)
  end

  def destroy
    if @item.user_id == current_user.id
      if @item.destroy
        render "items/delete"
      else
        render "items/show"
      end
    end
  end

  def buy
  end

  def purchase
    if signed_in? && @item.user_id != current_user.id
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      customer_token = current_user.card.customer_token
      Payjp::Charge.create(
        amount: @item.price, # 商品の値段
        customer: customer_token, # 顧客のトークン
        currency: 'jpy'  # 通貨の種類
      )
      @item_buyer_id= Item.find(params[:id])
      @item_buyer_id.update( buyer_id: current_user.id)
    else
      redirect_to root_path
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :introduction, :prefecture_id, :category_id,
      :condition_id, :postage_payer_id,:postage_type_id, :brand_name, :size,
      :preparation_day_id, :category_id, images_attributes: [:image_url, :id, :_destroy ]).merge(user_id: current_user.id)
  end

  def createCategoryId
    if params[:item][:category_child] == nil || params[:item][:category_child] == "child"
      @category_id = params[:item][:category_id]
    elsif params[:item][:category_grand_child] == "grand_child"
      @category_id = params[:item][:category_child]
    else
      @category_id = params[:item][:category_grand_child]
    end
  end

  def changeCategoryId
    if params[:item][:category_child] == "child"
      @category_id = params[:item][:category_id]
    elsif params[:item][:category_grand_child] == "grand_child"
      @category_id = params[:item][:category_child]
    else
      @category_id = params[:item][:category_grand_child]
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
