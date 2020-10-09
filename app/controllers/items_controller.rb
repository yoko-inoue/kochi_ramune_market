class ItemsController < ApplicationController
  def index
  end
  def new
  @item = Item.new
  end

  def buycheck
    if signed_in?
      @card = Card.get_card(current_user.card.customer_token) if current_user.card
    else
      redirect_to new_user_session_path
    end
  end
end
