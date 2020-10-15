class CardsController < ApplicationController
  def index
    @card = Card.get_card(current_user.card.customer_token) if current_user.card
  end

  def new
    if signed_in?
      @card = Card.new
      card = Card.where(user_id: current_user.id)
      redirect_to action: "index" if card.exists?
    else 
      redirect_to root_path
    end
  end

  def create
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]

    customer = Payjp::Customer.create(card: params[:payjp_token]) ## 顧客の作成

    card = current_user.build_card(customer_token: customer.id)
    if card.save
      redirect_to cards_path
    else
      redirect_to new_card_path
    end
  end

  def destroy
    card = current_user.card
  
    if card.destroy
      redirect_to cards_path
    else
      redirect_to cards_path
    end
  end
end
