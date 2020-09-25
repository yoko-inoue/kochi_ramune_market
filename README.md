## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|

### Association
- has_many :to_do_lists
- has_many :user_evaluations
- has_many :sell_items
- has_many :buy_items
- has_one :credit_card
- has_one :profile

## profilesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|user_id|reference|null: false, foreign_key: true|

### Association
- belongs_to:user

## Sending_destinationテーブル
|Column|Type|Options|
|------|----|-------|
|destination_first_name|string|null: false|
|destination_last_name|string|null: false|
|destination_first_name_kana|string|null: false|
|destination_last_name_kana|string|null: false|
|post_code|integer(7)|null: false|
|prefecture|integer|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string||
|phone_number|integer|unique: true|
|user_id|reference|null: false, foreign_key: true|

### Association
- belongs_to:user

## Credit_Cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|

### Association
- belongs_to :user

## user_Evaluationテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|item_id|reference|null: false, foreign_key: true|
|review|text|null: false|

### Association
- belongs_to :user
- belongs_to :item

## TO_DO_listテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|list|text||

### Association
- belongs_to :user

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introduction|text|null: false|
|price|integer|null: false|
|category_id|reference|null:false,foreign_key: true|
|size_id|reference|null:false,foreign_key: true|
|brand_id|reference|null:false,foreign_key: true|
|item_condition_id|reference|null:false,foreign_key: true|
|postage_payer_id|reference|null:false,foreign_key: true|
|prefecture_code|integer|null: false|
|preparation_day_id|reference|null:false,foreign_key: true|
|seller_id|reference|null:false,foreign_key: true|
|buyer_id|reference|foreign_key: true|

### Association
- has_many :item_images
- has_one :user_evaluation
- belongs_to :category
- belongs_to :size
- belongs_to :brand
- belongs_to :item_condition
- belongs_to :postage_payer
- belongs_to :preparation_day
- belongs_to :postage_type
- belongs_to :seller
- belongs_to :buyer

## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|reference|null: false, foreign_key: true|
|url|string|null: false|

### Association
- belongs_to :items

## Categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items

## Sizesテーブル
|Column|Type|Options|
|------|----|-------|
|size|string|null: false|

### Association
- has_many :items

## Brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items

## item_conditionテーブル
|Column|Type|Options|
|------|----|-------|
|item_condition|string|null: false|

### Association
- has_many :items

## Postage_payersテーブル
|Column|Type|Options|
|------|----|-------|
|postage_payer|string|null: false|

### Association
- has_many :items

## Preparation_daysテーブル
|Column|Type|Options|
|------|----|-------|
|preparation_day|string|null: false|

### Association
- has_many :items

## Postage_typesテーブル
|Column|Type|Options|
|------|----|-------|
|postage_type|string|null: false|

### Association
- has_many :items
