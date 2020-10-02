class CardController < ApplicationController
  before_action :move_to_root
  before_action :set_card,    only: [:new, :show, :destroy, :buy, :pay]
  before_action :set_item,    only: [:buy, :pay]
  require "payjp"

  def new
    if user_signed_in?
      card = Card.where(user_id: current_user.id)
      redirect_to users_path(current_user.id) if card.present?
    else
      redirect_to user_session_path
    end
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(

      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end 

  def show #Cardのデータpayjpに送り情報を取り出します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.payjp_id)
    end
  end

  

  private
  def move_to_root
    redirect_to root_path unless user_signed_in?
  end

  def set_card
    @set_card=Card.where(user_id: current_user.id)
  end

  def set_item
    # @item=Item.find(params[:item_id])
  end
end