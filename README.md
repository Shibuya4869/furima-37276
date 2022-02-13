# テーブル設計

## users テーブル

| Column          | Type   | Options                  |
| --------------- | ------ | ------------------------ |
| nickname        | string | null:false               |
| mail            | string | null:false, unique: true |
| password        | string | null:false               |
| first_name      | text   | null:false               |
| last_name       | text   | null:false               |
| first_name_kana | text   | null:false               |
| last_name_kana  | text   | null:false               |
| birthday        | date   | null:false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column       | Type       | Options                       |
| ------------ | ---------- | ----------------------------- |
| user         | references | null:false, foreign_key: true |
| name         | string     | null:false                    |
| description  | text       | null:false                    |
| category     | text       | null:false                    |
| condition    | text       | null:false                    |
| shipping_fee | text       | null:false                    |
| prefecture   | text       | null:false                    |
| schedule     | text       | null:false                    |
| price        | integer    | null:false                    |
| sold         | boolean    | null:false                    |

### Association

- belongs_to :user
- has_one :orders

# orders テーブル

| Column | Type       | Options                       |
| ------ | ---------- | ----------------------------- |
| user   | references | null:false, foreign_key: true |
| item   | references | null:false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

# addresses テーブル

| Column     | Type       | Options                       |
| ---------- | ---------- | ----------------------------- |
| order      | references | null:false, foreign_key: true |
| post_code  | text       | null:false                    |
| prefecture | text       | null:false                    |
| city       | text       | null:false                    |
| address    | text       | null:false                    |
| building   | text       | null:false                    |
| phone      | text       | null:false                    |

### Association

- belongs_to :order
