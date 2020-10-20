crumb :root do
  link "フリマ", root_path
end

crumb :mypage do
  link "マイページ", user_path(current_user)
end

crumb :payment_method do
  link "カード情報", cards_path
  parent :mypage
end

crumb :new_payment_card do
  link "クレジットカード情報入力", new_card_path
  parent :mypage
end

crumb :item_name do |item|
  link "#{item.name}"
end